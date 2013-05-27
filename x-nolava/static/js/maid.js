var camera, scene, renderer,
geometry, material, meshs;
window.onload = function(){
    init();
    animate(); 
    function init() {
        scene = new THREE.Scene();
        camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 100000 );
        camera.position.z = 10000;
        scene.add(camera); 

	var ambient = new THREE.AmbientLight( 0x888888 );
	scene.add( ambient );

	directionalLight = new THREE.DirectionalLight( 0xffffff, 0.7 );
	directionalLight.position.set( 1, 1, 2 ).normalize();
	scene.add( directionalLight );

	pointLight = new THREE.PointLight( 0x000000 );
	pointLight.position.set( 0, 0, 0 );
	scene.add( pointLight ); 
	// light representation
	
	sphere = new THREE.SphereGeometry( 100, 16, 8, 1 );
	//lightMesh = new THREE.Mesh( sphere, new THREE.MeshLambertMaterial( { color: 0xffffff } ) );
	//lightMesh.scale.set( 0.02, 0.02, 0.02 );
	//lightMesh.position = pointLight.position;
	//scene.add( lightMesh );
	
        renderer = new THREE.WebGLRenderer({antialias:true});
        renderer.setSize( window.innerWidth, window.innerHeight );
	
        document.body.appendChild( renderer.domElement );
	
	var callback = function(geometry){
	    var count = 20;
	    window.meshs = [];
	    for(var i=0;i<count;i++){
		var mesh = new THREE.Mesh(geometry,new THREE.MeshFaceMaterial());
		meshs.push(mesh);
		mesh.scale.set(20,20,20);
		mesh.position.set(-8000+i*1000,-3000,500);
		mesh.rotation.set(0,0,0); 
		scene.add(mesh);
	    }
	}
	var loader = new THREE.JSONLoader(true);
	loader.load("obj/1/out.js ", callback );
	

    }
    var index=0;
    function animate() {
        // note: three.js includes requestAnimationFrame shimm
        requestAnimationFrame(animate);
        render();
	index++;
	window.d = Date.now(); 
	try{
	    console.log(window.meshs.length);
	    for(var i=0;i<window.meshs.length;i++){
		var mesh = meshs[i];
		mesh.rotation.set(0,index*0.01,0);
	    }
	}catch(e){
	    console.log(e.toString());
	}
	if(window._d){
	    //console.log("fps:",1000/(d-_d));
	}
	window._d = d;
    }
    function render() {
        renderer.render( scene, camera );

    }
}
