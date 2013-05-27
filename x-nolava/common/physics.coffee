Three = (require "../common/three-node.js").THREE
Vector3 = Three.Vector3
Quaternion = Three.Quaternion
EventEmitter = (require "events").EventEmitter

class PhysicsObject extends EventEmitter
    constructor:(data)->
        super()
        console.assert data
        if typeof data.id is "number"
            @id = parseInt(data.id)
        else if typeof data.id is "string" and not isNaN(parseInt(data.id) )
            @id = parseInt(data.id)
        # property belows are defined by the constructor and will not change in anyway
        #using mass as one turn @force in to @acceloration
        @mass = 1
        # used to preform Stork Drag
        # not currently enabled
        # @resistFactor = 0.1 
        
        @minUpdates = 10 #microsecond less than this will be kept
        @maxUpdates = 100 #more than this will doit nextime

        # to avoid using hark storke drag intergrate
        # we simply set max speed and max rotate speed
        @maxSpeed = 10 
        @maxRotateSpeed = 1

        @updateProperties(data)
        @constructor = data.constructor

    updateProperties:(data)->
        console.assert data
        @vector3s = ["position","velocity","rotateVelocity","rotateAcceleration","force"] 
        for prop in @vector3s
            if not @[prop] 
                @[prop] = new Vector3
            if data[prop]
                @[prop].copy data[prop]

        if not @quaternion
            @quaternion = new Quaternion()
        if data.quaternion
            @quaternion.copy(data.quaternion)
        #if data.constructor is "Bullet"
            #console.log "!!",@quaternion

    toData:()->
        return {
            id:@id,
            constructor:"PhysicsObject",
            position:{x:@position.x,y:@position.y,z:@position.z},
            force:{x:@force.x,y:@force.y,z:@force.z},
            rotateAcceleration:{x:@rotateAcceleration.x,y:@rotateAcceleration.y,z:@rotateAcceleration.z},
            rotateVelocity:{x:@rotateVelocity.x,y:@rotateVelocity.y,z:@rotateVelocity.z},
            velocity:{x:@velocity.x,y:@velocity.y,z:@velocity.z},
            quaternion:{x:@quaternion.x,y:@quaternion.y,z:@quaternion.z,w:@quaternion.w},
        } 
    updatePhysics:(deltaTime)->
        # deltaTime in ms
        while deltaTime > @maxUpdates
            @updatePhysics(@maxUpdates)
            deltaTime -= @maxUpdates
        console.assert deltaTime >= 0
        for prop in ["x","y","z"]
            do (prop)=>
                @position[prop] += RK4 deltaTime,(t)=>
                    return @velocity[prop]+t*@force[prop]/@mass
                @velocity[prop] += deltaTime*@force[prop]/@mass
        if @velocity.length() > @maxSpeed
            @velocity.normalize()
            @velocity.multiplyScalar(@maxSpeed)
        # handle rorate
        # using Euler Integrate
        rotation = @rotateVelocity.clone().multiplyScalar(deltaTime/1000)
#        if rotation.x>0 or rotation.y >0 or rotation.z >0
#            console.log rotation.x,rotation.y,rotation.z
        rotationQuaternion = new Quaternion().setFromEuler(rotation)
        
        @quaternion.multiply(rotationQuaternion)
        # instead using stork drag simply set max rotate speed here
        @rotateVelocity.add(@rotateAcceleration)
        @rotateVelocity.multiplyScalar(Math.pow(0.3,deltaTime/1000))
        if @rotateVelocity.length() > @maxRotateSpeed
            @rotateVelocity.normalize().multiplyScalar(@maxRotateSpeed)
    update:(time)->
        @updatePhysics(time)
PhysicsObject.UsedId = 1
PhysicsObject.getNewId = ()->
    id = PhysicsObject.UsedId
    PhysicsObject.UsedId  += 1
    return id
PhysicsObject.constructors = {}
class World extends EventEmitter
    constructor:()->
        super()
        @objects = []
        @toRemove = []
    update:()->
        
        time = Date.now()
        if not @lastUpdate
            @lastUpdate = time
        delta = time-@lastUpdate
        @lastUpdate = time
        for object,index in @objects
            object.update(delta)
            if object.hitCheck
                object.hitCheck(@objects,delta)
            if object.markRemove
                @toRemove.push object
        for object in @toRemove
            @remove object 
        @toRemove.length = 0
    updateObject:(obj)->
        if not @inited
            return
        console.assert obj
        console.assert obj.id
        item = @getObjectById(obj.id)
        if not item
            # create object so updateObject should be used with checks in server
            object = @createObject(obj)
            @add object
        else
            item.updateProperties(obj)
    createObject:(object)->
        constructor = PhysicsObject.constructors[object.constructor]
        #console.log object,constructor,PhysicsObject.constructors
        new constructor(object)
    init:(objects)->
        @inited = true
        console.assert objects
        @clear()
        for object in objects
            
            object = @createObject(object)
            @add object
    add:(object)-> 
        console.assert object instanceof PhysicsObject
        @objects.push object
        @emit "add",object
    clear:()->
        # clear dont emit any event
        @objects.length = 0
    remove:(target)->
        for object,index in @objects
            if object.id is target.id
                @objects.splice(index,1)
                @emit "remove",object
                return true
        return false
    toData:()->
        return (item.toData() for item in @objects) 
    getObjectById:(id)->
        console.assert id
        for object in @objects
            if object.id is id
                return object
        return null
RK4 = (delta,xFunc)->
    k1 = delta*xFunc(0)
    k2 = delta*xFunc(0+delta/2)
    k3 = delta*xFunc(0+delta/2)
    k4 = delta*xFunc(0+delta)
    y1 = k1/6+k2/3+k3/3+k4/6
    return y1
    
        
exports.PhysicsObject = PhysicsObject
exports.World = World 
                     