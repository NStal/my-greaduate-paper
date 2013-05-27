class GameObject extends Leaf.EventEmitter
    constructor:(mesh)->
        super()
        if mesh
            @mesh = mesh
        if @mesh
            @mesh.useQuaternion = true
        @scale = 1;
        @position = new Three.Vector3(0,0,0);
        @quaternion = new Three.Quaternion(0,0,0,1);
        @towards = new Three.Vector3(0,0,-1);
        @speed = 0
        @turnSpeed = 0
        @eulerTurnSpeed = 0.08
        @minTurnSpeed = 0.0001
        @turnSpeedAccelerator = 0.003
        @turnQuaternion = new Three.Quaternion
        @isShown = false
        
    update:()->
        @towards.set(0,0,-1)
        @towards.applyQuaternion(@quaternion).setLength(@speed)
        @position.add(@towards)
        @quaternion.multiply @turnQuaternion
        @turnQuaternion.set(0,0,0,1)
        
        if @relateTarget and @relateVector
            vec3 = @relateVector.clone()
            vec3.applyQuaternion(@relateTarget.quaternion)
            @position.copy @relateTarget.position
            @position.add(vec3)
        else if @destination
            @moveTo(@destination)
        if @mesh
            @mesh.position.copy @position
            @mesh.quaternion.copy @quaternion
            @mesh.scale.set(@scale,@scale,@scale)
    show:()->
        @emit "show"
        if @isShown
            return
        GameObject.instances.push this
        if @mesh
            Static.game.scene.add @mesh
        @isShown = true
    hide:()->
        @emit "hide"
        if not @isShown
            return
        if @mesh 
            Static.game.scene.remove @mesh
        @isShown = false
        for item,index in GameObject.instances
            if item is this
                GameObject.instances.splice(index,1)
                return true
        return false
    relateTo:(gobject,distanceVector)->
        console.assert distanceVector instanceof Three.Vector3
        @relateTarget = gobject
        @relateVector = distanceVector
    forward:()->
        return
    moveTo:(destination)->
        @turnTo(destination)
        @forward()
    turnTo:(destination)->
        m1 = new Three.Matrix4()
        m1.lookAt(@position,destination,@mesh.up)
        quaternion = new Three.Quaternion().setFromRotationMatrix(m1) 
        result = Static.Interpolation(@quaternion,quaternion,["x","y","z","w"],@turnSpeed,true,{})
        
        @quaternion.copy(result)
        @quaternion.normalize()
    setDestination:(destination)->
        @destination = destination
GameObject.instances = []
GameObject.update = ()->
    for item in @instances
        if not item 
            return
        item.update()
        item.emit "update",item,this
class Ship extends GameObject
    constructor:(model)->
        @object = Static.resourceManager.objects[model]
        mesh = new Three.Mesh(@object.geometry,@object.material)
        super(mesh)
        @speedVector = new Three.Vector3(0,0,0);
        @speed = 0
        @turnSpeed = 0.005
        @turnEuler = new Three.Vector3(0,0,0)
        @mesh.useQuaternion = true
        positions = [] 
        positions=[new Three.Vector3(0,44,400),new Three.Vector3(60,-42,400),new Three.Vector3(-60,-42,400)]
        @lights = []
        for position in positions
            glow =  new LightGlow(600)
            glow.relateTo(this,position)
            sharp = new WhiteSharp(800)
            sharp.relateTo(this,position)
            @lights.push glow,sharp
    show:()->
        super()
        for light in @lights
            light.show()
    hide:()->
        for light in @lights
            light.hide()
        super()
        
    turn:(towards)->
        switch towards
            when "left"
                @turnEuler.y += @turnSpeedAccelerator
            when "right"
                @turnEuler.y -= @turnSpeedAccelerator 
            when "up"
                @turnEuler.x += @turnSpeedAccelerator
            when "down"
                @turnEuler.x -= @turnSpeedAccelerator
            when "none"
                @turnEuler.x *= 0.8
                @turnEuler.y *= 0.8
        # limit
        if Math.abs(@turnEuler.y) > @eulerTurnSpeed then @turnEuler.y = @eulerTurnSpeed*@turnEuler.y/Math.abs(@turnEuler.y)
        if Math.abs(@turnEuler.x) > @eulerTurnSpeed then @turnEuler.x = @eulerTurnSpeed*@turnEuler.x/Math.abs(@turnEuler.x)
        if Math.abs(@turnEuler.y) < @minTurnSpeed then @turnEuler.y = 0
        if Math.abs(@turnEuler.x) < @minTurnSpeed then @turnEuler.x = 0 
        @turnQuaternion.multiply new Three.Quaternion().setFromEuler @turnEuler
        
        
class Bullet extends GameObject
    constructor:()->
        @object = Static.resourceManager.objects["bullet"]
        mesh = new Three.Mesh(@object.geometry,@object.material) 
        super(mesh)
        @speed = 1000
        @turnSpeed = 0.001
        @maxDistance = 1000*30
        @distance = 0
    update:()->
        @distance += @speed
        if @distance >= @maxDistance
            @hide()
            explotion = new WhiteSharpExplotion()
            explotion.position.copy @position
            explotion.show()
        else
            super()

class Ball extends GameObject
    constructor:()->
        @object = Static.resourceManager.objects["ball"]
        mesh = new Three.Mesh(@object.geometry,@object.material) 
        super(mesh)

        @speed = 0
        @turnSpeed = 0
            
class CameraFacedObject extends GameObject
    constructor:()->
        super()
    update:()->
        @quaternion.copy Static.game.camera.quaternion
        super()
class LightGlow extends CameraFacedObject
    constructor:(size)->
        console.log "LightGlow"
        super()
        @size = size or 600 
        #mat = new Three.MeshBasicMaterial({map:Static.resourceManager.textures.trustHifi,opacity:0.9,color:0x33aaff,transparent:true,blending:Three.CustomBlending,blendSrc:Three.SrcAlphaFactor,blendDst:Three.OneFactor})
        #geo = new Three.PlaneGeometry(size,size,1,1)
        #mat.side = Three.DoubleSide;
        #geo.applyMatrix(new Three.Matrix4().makeTranslation(-size/200,size*47/56,0))
        #geo2 = geo.clone()
        #geo2.applyMatrix(new Three.Matrix4().makeTranslation(0,0,-20))
        #mesh1 = new Three.Mesh(geo,mat)
        #mesh2 = new Three.Mesh(geo2,mat)
        #
       ##mesh1.applyMatrix(new Three.Matrix4().makeRotationZ(Math.PI/2))
        #mesh2.applyMatrix(new Three.Matrix4().makeRotationZ(-Math.PI))
        #mesh2.position.y = 1000
        #mesh1.add mesh2
        #@mesh = mesh1
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
        @position.set(0,0,0)
        @mesh.useQuaternion = true
    update:()->
        super()
        @spriteScale = @size+100*(Math.random()-0.5)
        @sprite1.position.x=@spriteScale*1.1/4
        @sprite2.position.x=-@spriteScale*1.1/4
        @sprite1.scale.set(@spriteScale,@spriteScale,@spriteScale)
        @sprite2.scale.set(@spriteScale,@spriteScale,@spriteScale)

class WhiteSharp extends CameraFacedObject
    constructor:(size)->
        super()
        @size = size or 800
        mat = new Three.SpriteMaterial({map:Static.resourceManager.textures.whitesharp,opacity:1,color:0xffffff,transparent:true,blending:Three.CustomBlending,blendSrc:Three.SrcAlphaFactor,blendDst:Three.OneFactor,useScreenCoordinates: false})
        mat.side = Three.DoubleSide
        @mesh = new Three.Sprite(mat)
        @spriteScale = @size
        @position.set(0,0,0)
        @mesh.useQuaternion = true
    update:()->
        super()
        @mesh.scale.set(@spriteScale,@spriteScale,@spriteScale)
class Missile extends GameObject
    constructor:()-> 
        @object = Static.resourceManager.objects["missile"]
        mesh = new Three.Mesh(@object.geometry,@object.material)
        super(mesh)
        @scale = 50
        @speed = 0
        @turnSpeed = 0.01
        @turnEuler = new Three.Vector3(0,0,0)
        positions=[new Three.Vector3(0,0,255)]
        @lights = []
        for position in positions
            glow =  new LightGlow(200)
            glow.relateTo(this,position)
            sharp = new WhiteSharp(250)
            sharp.relateTo(this,position)
            @lights.push glow,sharp
    show:()->
        super()
        for light in @lights
            light.show()
    hide:()->
        for light in @lights
            light.hide()
        super()
        
class WhiteSharpExplotion extends CameraFacedObject
    constructor:(maxSize)->
        super()
        @size = 100
        mat = new Three.SpriteMaterial({map:Static.resourceManager.textures.whitesharp,opacity:0.7,color:0xffffff,transparent:true,blending:Three.CustomBlending,blendSrc:Three.SrcAlphaFactor,blendDst:Three.OneFactor,useScreenCoordinates: false})
        mat.side = Three.DoubleSide

        @mesh = new Three.Sprite(mat)
        @spriteScale = @size
        @position.set(0,0,0)
        @mesh.useQuaternion = true
        this.lowSpeed = 1.03;
        this.fastSpeed = 2;
        this.floor = 30;
        this.max = (maxSize or 800)*(Math.random()+1)/2;
        this.min = 1;
        this.delay = 0.9;
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
        @spriteScale = @size * @expSize
        @mesh.scale.set(@spriteScale,@spriteScale,@spriteScale)
Static.Hitables = []
Static.GameObject = GameObject;
Static.Ship = Ship;
Static.Bullet = Bullet
Static.Ball = Ball
Static.LightGlow = LightGlow
Static.Missile = Missile
Static.WhiteSharpExplotion = WhiteSharpExplotion