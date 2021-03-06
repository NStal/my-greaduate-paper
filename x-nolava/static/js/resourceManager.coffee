class ResourceManager extends Leaf.TemplateManager 
    constructor:()->
        super()
        @objects = {}
        @objectFolder = "obj"
        @infoFile = "info.json"
        @textures = {}
        @textureFolder = "texture"
        @meshes = {}
    useObject:(name,callback)->
        @objects[name] = null
        loader = new Three.JSONLoader(true)
        loader.load [@objectFolder,name,@infoFile].join("/"),(geometry,materials)=>
            @objects[name] = {geometry:geometry,materials:materials}
            if @_isRequirementComplete()
                @_ready() 
            if callback
                callback(geometry)
    _isRequirementComplete:()->
        if not super()
            return false
        for item of @objects
            if @objects[item] is null
                return false
        return true
    preprocess:()->
        shader	= Three.ShaderLib["cube"];
        urlPrefix	= "texture/a04_cube.";
        urls = [ urlPrefix + "px.jpg", urlPrefix + "nx.jpg",
        urlPrefix + "py.jpg", urlPrefix + "ny.jpg",
        urlPrefix + "pz.jpg", urlPrefix + "nz.jpg" ];

        @textures.cube = Three.ImageUtils.loadTextureCube urls
        @textures.cube.format = Three.RGBFormat;
        shader.uniforms["tCube"].value = @textures.cube;
        cubeMaterial = new Three.ShaderMaterial({
            fragmentShader	: shader.fragmentShader,
            vertexShader	: shader.vertexShader,
            uniforms: shader.uniforms,
        })
        cubeMaterial.side = Three.BackSide
        @meshes.environmentCube= new Three.Mesh( new Three.CubeGeometry( 1000000000, 1000000000, 1000000000, 1, 1, 1, null, true ), cubeMaterial)
        
        #spaceShips
        @objects["Spaceship"].geometry.applyMatrix(new Three.Matrix4().makeRotationY(Math.PI/2))
        @objects["Spaceship"].material = new Three.MeshFaceMaterial(@objects["Spaceship"].materials)
        @objects["Spaceship"].material.materials[0] = new Three.MeshPhongMaterial({color:0xffffff}) 
        @objects["Spaceship"].material.materials[0].envMap = @textures.cube;
        @objects["Spaceship"].material.materials[0].reflectivity=1.0;
        @objects["missile"].material = new Three.MeshFaceMaterial(@objects["missile"].materials)

        @objects["missile"].geometry.applyMatrix(new Three.Matrix4().makeRotationY(-Math.PI/2))
        @objects["missile"].material.materials[0] = new Three.MeshLambertMaterial({color:0xffffff})
        @objects["missile"].material.materials[0].reflectivity=0.9;
        #@objects["Spaceship"].material.materials[1].envMap = @textures.cube;

        trustHifi = Three.ImageUtils.loadTexture("./texture/propeller/trusthifi.png")
        trustHifi.wrapS = trustHifi.wrapT = Three.RepeatWrapping
        @textures.trustHifi = trustHifi
        
        whitesharp = Three.ImageUtils.loadTexture("./texture/propeller/whitesharp.png")
        whitesharp.wrapS = whitesharp.wrapT = Three.RepeatWrapping
        @textures.whitesharp = whitesharp
        
        bullet = {}
        bullet.geometry = new Three.CubeGeometry(12,12,3000,1,1,1,null,true)
        bullet.material = new Three.ParticleBasicMaterial({color:0xff9966})
        @objects["bullet"] = bullet;
        @meshes.bullet = new Three.Mesh(bullet.geometry,bullet.material)
        ball = {}
        ball.geometry = new Three.SphereGeometry()
        ball.material = new Three.ParticleBasicMaterial({color:0x00ffff})
        @objects["ball"] = ball;
        @meshes.ball = new Three.Mesh(ball.geometry,ball.material)
        #build meshed
        @meshes.ship = new Three.Mesh(@objects.Spaceship.geometry,@objects.Spaceship.material)
        
        
    getMesh:(name)->
        console.assert this.meshes[name] 
        return this.meshes[name].clone()
exports.ResourceManager = ResourceManager