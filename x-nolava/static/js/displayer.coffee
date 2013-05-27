# How it works:
# We introduct a new concept called Tracer
# Tracer is used to adopt a physics object to
# allow it show on screen
# just like real world
# we use the tracer to trace the physical state
# of the object and tell displayer to  display it on screen.
# Tracer is attached to object when it's added to world
# and removed when it's removed from the world
# Every time displayer needs render or update
# we call every tracer to update the infos.
class Displayer extends Leaf.Widget
    constructor:()->
        super("#scene")
    setWorld:(world)->
        console.assert world
        @world = world
        @world.on "add",(object)=>
            @attachTracer(object)
        @world.on "remove",(object)=>
            @removeTracer(object)
    setup:()->
        @setupEnvironment()
        @setupScene()
        @environment = new SpaceEnvironment()
        @environment.show()
        
    setupEnvironment:()->
        @frameRate = 70
        @canvas = @UI.canvas
        @height = window.innerHeight
        @width = window.innerWidth
        @canvas.width = @width
        @canvas.height = @height
        @ratio = @width/@height
    setupScene:()->
        @scene = new Three.Scene()

        @camera = new Static.ShipCamera(35,@ratio,1,1000000000)
        @camera.position.z = 300
        @scene.add(@camera)
        @renderer = new Three.WebGLRenderer({canvas:@canvas,antialias:true,clearColor:0x000000})
        @renderer.setClearColor(0x000000, 1);
        @renderer.setSize(@width,@height)

        #@composer = new Three.EffectComposer(@renderer);
        #@renderPass = new Three.RenderPass(@scene,@camera)
        #@composer.addPass(@renderPass)
        #hblur = new Three.ShaderPass(Three.HorizontalBlurShader)
        #vblur = new Three.ShaderPass( Three.VerticalBlurShader )
        #vblur.renderToScreen = true;
        #@composer.addPass( hblur ); 
        #@composer.addPass( vblur );
        ambient = new Three.AmbientLight( 0x999999 ,0.9);
        directionalLight = new Three.DirectionalLight(0xffffff,0.7)
        directionalLight.position.set(1,1,2).normalize()
        pointLight = new Three.PointLight(0x224488,0.9);
        pointLight.position.set(0,0,0)
        
        @scene.add(ambient) 
        @scene.add(directionalLight)
        @scene.add(pointLight)
    
    update:()->
        @camera.update()
        console.assert @world
        for obj,index in Displayer.tracers
            obj.update()
            if obj.markRemove
                Displayer.tracers[index] = null
        Displayer.tracers = Displayer.tracers.filter (item)->item isnt null
        @renderer.render(@scene,@camera)
    attachTracer:(object)->
        if object instanceof Bullet
            tracer = new BulletTracer(object)
            tracer.show()
            return
        if object instanceof Ship
            tracer = new ShipTracer(object)
            tracer.show()
            return
    removeTracer:(object)->
        if not object.tracers
            return
        for tracer in object.tracers
            tracer.hide()
Displayer.tracers = []
            
class Tracer extends EventEmitter
    constructor:(object)->
        super()
        console.assert typeof object is "object"
        if not object.tracers
            object.tracers=[]
        object.tracers.push(this)
        @target = object
        @position = new Three.Vector3().copy @target.position
        @quaternion = new Three.Quaternion().copy @target.quaternion
    show:()->
        if not @mesh
            return
        @emit "show"
        if @isShown
            return
        Static.game.displayer.scene.add @mesh
        Displayer.tracers.push this
        @isShown = true
    hide:()->
        if not @mesh
            return
        @emit "hide"
        if not @isShown
            return
        Static.game.displayer.scene.remove @mesh
        @markRemove = true
                
    update:()->
        @position.copy @target.position
        @quaternion.copy @target.quaternion

class ShipTracer extends Tracer
    constructor:(object)-> 
        super(object)
        @mesh = Static.resourceManager.getMesh("ship")
        @mesh.useQuaternion = true
        positions = [] 
        positions=[new Three.Vector3(0,44,400),new Three.Vector3(60,-42,400),new Three.Vector3(-60,-42,400)]
        @lights = []
        @hud = new ShipHUD(@target)
        console.log "！@！！！"
        for position in positions
            glow =  new LightGlow(this,600)
            glow.setRelation(position)
            sharp = new WhiteSharp(this,850)
            sharp.setRelation(position)
            @lights.push glow,sharp
    show:()->
        super()
        @hud.show()
        for light in @lights
            light.show()
    hide:()->
        @hud.hide()
        for light in @lights
            light.hide()
        super()
    update:()->
        super()
        @mesh.position.copy @position
        @mesh.quaternion.copy @quaternion
        for light in @lights
            light.update()
# TracerDecorator is used to decorate
# tracers to provide extra effect
# such as flame or something
# TracerDecorator is also an tracer
# A Tracer that trace tracer
class BulletTracer extends Tracer
    constructor:(object)->
        super(object)
        @mesh = Static.resourceManager.getMesh("bullet")
        @mesh.useQuaternion = true
        object.on "explosion",()=>
            console.log "Boooom!"
            @explosion.position.copy @position
            @explosion.show()
            @explosion.update()
        @explosion = new WhiteSharpExplotion(this)
        @explosion.on "end",()=>
            @hide()
            @target.markRemove = true
    update:()->
        super()
        @mesh.position.copy @position
        @mesh.quaternion.copy @quaternion
class TracerDecorator extends Tracer
    constructor:(object)->
        super(object)
    setRelation:(distanceVector)->
        @relateVector = distanceVector
    update:()->
        super()
        if @relateVector
            vec3 = @relateVector.clone()
            vec3.applyQuaternion(@target.quaternion)
            @position.copy @target.position
            @position.add(vec3)
class LightGlow extends TracerDecorator
    constructor:(tracer,size)->
        super(tracer)
        @size = size or 600
        mat = new Three.SpriteMaterial({map:Static.resourceManager.textures.trustHifi,opacity:1,color:0x33aaff,transparent:true,blending:Three.CustomBlending,blendSrc:Three.SrcAlphaFactor,blendDst:Three.OneFactor,useScreenCoordinates: false})
        mat.side = Three.DoubleSide
        @sprite1 = new Three.Sprite(mat)
        @sprite2 = new Three.Sprite(mat)
        @sprite1.rotation = -Math.PI/2
        @sprite2.rotation = Math.PI/2
        @mesh = new Three.Object3D()
        @mesh.add @sprite1
        @mesh.add @sprite2
        @spriteScale = @size
        @mesh.useQuaternion = true 
    update:()->
        super()
        @mesh.position.copy @position
        @mesh.quaternion.copy @quaternion
        @spriteScale = @size+100*(Math.random()-0.5)
        @sprite1.position.x=@spriteScale*0.78/4
        @sprite2.position.x=-@spriteScale*0.78/4
        @sprite1.scale.set(@spriteScale,@spriteScale,@spriteScale)
        @sprite2.scale.set(@spriteScale,@spriteScale,@spriteScale)
class WhiteSharp extends TracerDecorator
    constructor:(object,size)->
        super(object)
        @size = size or 800
        mat = new Three.SpriteMaterial({map:Static.resourceManager.textures.whitesharp,opacity:1,color:0xffffff,transparent:true,blending:Three.CustomBlending,blendSrc:Three.SrcAlphaFactor,blendDst:Three.OneFactor,useScreenCoordinates: false})
        mat.side = Three.DoubleSide
        @mesh = new Three.Sprite(mat)
        @spriteScale = @size
        @position.set(0,0,0)
        @mesh.useQuaternion = true
    update:()->
        super()
        @mesh.position.copy @position
        @mesh.quaternion.copy @quaternion 
        @mesh.scale.set(@spriteScale,@spriteScale,@spriteScale)

class WhiteSharpExplotion extends TracerDecorator
    constructor:(tracer,maxSize)->
        super(tracer)
        @size = 100
        mat = new Three.SpriteMaterial({map:Static.resourceManager.textures.whitesharp,opacity:0.7,color:0xffffff,transparent:true,blending:Three.CustomBlending,blendSrc:Three.SrcAlphaFactor,blendDst:Three.OneFactor,useScreenCoordinates: false})
        mat.side = Three.DoubleSide

        @mesh = new Three.Sprite(mat)
        @spriteScale = @size
        @mesh.useQuaternion = true
        this.lowSpeed = 1.15;
        this.fastSpeed = 2;
        this.floor = 30;
        this.max = (maxSize or 1500)*(Math.random()+1)/2;
        this.min = 1;
        this.delay = 0.1
        this.expSize = 2
        @state = "start"
    update:()->
        super()
        if @state is "start"
            if Math.random() < @delay
                return
            else
                @state = "preIncrease"
        if @state is "preIncrease" 
            @expSize *= @lowSpeed
            if @expSize > @floor
                @state = "increase"
        if @state is "increase"
            @expSize *= @fastSpeed
            if @expSize > @max
                @state = "decrease"
        if @state is "decrease"
            @expSize /= @fastSpeed
            if @expSize < @floor
                @state = "preEnd"
        if @state is "preEnd"
            @expSize /= @lowSpeed
            if @expSize < @min
                @state = "remove" 
        if @state  is "remove"
            @hide()
            @emit "end"
        @spriteScale = @size * @expSize
        @mesh.position.copy @position
        @mesh.scale.set(@spriteScale,@spriteScale,@spriteScale)
class ShipHUD extends TracerDecorator
    constructor:(target)->
        super(target)
        @p4 = new Three.Vector4
        @mesh = new Three.Sprite(new Three.SpriteMaterial({map:Static.resourceManager.textures.whitesharp,color:0xff0000,useScreenCoordinates:true}))
        @mesh.scale.set(100,100,1)
        @camera = Static.game.displayer.camera
        @displayer = Static.game.displayer
    update:()->
        super()
        if @target is Static.game.userShip
            @mesh.visible = false
            return
        @p4.copy @position
        
        @p4.w = 1
        @p4 = @p4.applyMatrix4(@camera.matrixWorldInverse)
        oz = @p4.z
        @p4 = @p4.applyMatrix4(@camera.projectionMatrix)
        z = @p4.z
        @p4.multiplyScalar(1/z)
        x = (@p4.x+1)/2*@displayer.width
        y = -(@p4.y-1)/2*@displayer.height
        x = Math.max(8,Math.min(x,@displayer.width-5))
        y = Math.max(8,Math.min(y,@displayer.height-5))
        @mesh.position.set(x,y,0)
        # v3 = @camera.position.clone().sub(@position).dot(new Vector3(0,0,1).applyQuaternion(@camera.quaternion))
        if z >  0
            @mesh.visible = true
        else
            @mesh.visible = false
        
class SpaceEnvironment extends EventEmitter 
    constructor:()->
        super()
        # pass
        @cube = Static.resourceManager.getMesh("environmentCube")
        
        @ball =  Static.resourceManager.getMesh("ball")
        @ball.position.set(0,0,0)
    show:()-> 
        Static.game.displayer.scene.add @cube
        Static.game.displayer.scene.add @ball
    hide:()->
        Static.game.displayer.scene.remove @cube
        Static.game.displayer.scene.remove @ball
exports.Displayer = Displayer
exports.SpaceEnvironment = SpaceEnvironment