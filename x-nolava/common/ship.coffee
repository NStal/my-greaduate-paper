Three = (require "../common/three-node.js").THREE
PhysicsObject = require("./physics").PhysicsObject 
class Ship extends PhysicsObject
    constructor:(data)->
        console.assert data
        super(data)
        state = 0
        @__defineGetter__ "state",()->
            return state
        @__defineSetter__ "state",(value)->
            if value isnt state
                state = value
        if data.state
            @state = data.state
        # Maybe a better name?
        @parameters = {}
        @params = @parameters
        @params.maxSpeed = 6
        @params.speedAcceleration = 0.1
        @params.rotateAccelerationNormal = 0.035
        @params.maxRotateSpeedNormal = 1.6
        @params.fireInterval = 100
        @constructor = "Ship"
    updatePhysicsByShipState:()->
        instr = ""
        if (@state & Ship.State.fire) is Ship.State.fire
            @firing = true
        else
            @firing = false
        if (@state & Ship.State.left) is Ship.State.left
            instr +="left "
            @rotateAcceleration.y = 1
        else if (@state & Ship.State.right) is Ship.State.right
            @rotateAcceleration.y = -1 
            instr +="right "
        else
            @rotateAcceleration.y = 0
        
        if (@state & Ship.State.up) is Ship.State.up
            instr +="up "
            @rotateAcceleration.x = 1
        else if (@state & Ship.State.down) is Ship.State.down
            instr +="down"
            @rotateAcceleration.x = -1
        else
            @rotateAcceleration.x = 0
        #if instr.trim()
            #console.log @state,instr
        if (@state & Ship.State.forward) is Ship.State.forward
            @force.set(0,0,-1)
            @force.applyQuaternion(@quaternion).multiplyScalar(@params.speedAcceleration)
        else
            @force.set(0,0,0)
        if @rotateAcceleration.length() > 0.01
            @rotateAcceleration.normalize().multiplyScalar(@params.rotateAccelerationNormal)
        @maxSpeed = @params.maxSpeed or 10
        @maxRotateSpeed = @params.maxRotateSpeedNormal or 1
        #console.log "ShipState:RotateAcceleration",@rotateAcceleration
    updateProperties:(data)->
        super(data)
        #console.log "updateProperties",data
        if typeof data.state is "number"
            @state = data.state
        @fireCooldown = data.fireCooldown or 0
    update:(time)->
        @updatePhysicsByShipState()
        super(time)
    updatePhysics:(time)->
        super(time)
        @fireCooldown -= time
        if @fireCooldown < 0
            @fireCooldown = 0
        if @firing and @fireCooldown is 0
            @fireCooldown = @params.fireInterval
            @emit "fire",new Bullet({quaternion:@quaternion.clone(),position:@position.clone(),velocity:@velocity.clone(),id:PhysicsObject.getNewId(),master:@id})
    toData:()->
        data = super()
        data.state = @state
        data.constructor = "Ship"
        data.fireCooldown = @fireCooldown
        #console.log "ship to data",data # 
        return data
class Bullet extends Ship
    constructor:(data)->
        super(data)
        @params.speedAcceleration = 10
        @params.maxExists = 1000
        @params.maxSpeed = 100
        @state = Ship.State.forward
        @life = data.life or 0
        @params.hitDistance = 1000
        @master = data.master
        @constructor = "Bullet"
        @ray = new Three.Ray(@position,new Three.Vector3(0,0,1).applyQuaternion(@quaternion))
    toData:()->
        data = super()
        delete data.fireCooldown
        delete data.constructor
        data.constructor = "Bullet"
        data.life = @life
        data.master = @master
        return data
    exploit:()->
        if @state is Ship.State.explosion
            return
        @markRemove = true
        @emit "explosion",this
        @state = Ship.State.explosion
    updatePhysics:(time)->
        super(time)
        @life += time
        if @life >= @params.maxExists
            @exploit()
            
    hitCheck:(objects,time)->
        for object in objects
            if object is this or object.constructor isnt "Ship" or object.id is @master
                continue
            rayDistance = @ray.distanceToPoint(object.position)
            if rayDistance < @params.hitDistance
                #console.error rayDistance
                # may be hit
                lengthToGoSquared = object.position.distanceToSquared(@position)-(rayDistance*rayDistance)
                #console.error "may hit",Math.sqrt(lengthToGoSquared)
                if lengthToGoSquared < (@maxSpeed*@maxSpeed*time*time)
                    # will hit
                    @emit "hit",object
                    #console.error "hit id",object.id,object.position.distanceTo(@position)
                    @exploit()
                    return
            
# using bit to combine compatible and imcompatible action
binaryToInt = (binaryString)->
    result = 0
    for byte in binaryString
        result *= 2
        console.assert byte is "0" or byte is "1"
        if byte is "1"
            result += 1
    return result
Ship.State = {
    left:              "1",
    right:            "10",
    up:              "100",
    down:           "1000",
    forward:       "10000",
    fire:         "100000",
    explosion:   "1000000",
}
# transfor to banari
do ()->
    for state of Ship.State
        Ship.State[state] = binaryToInt(Ship.State[state])
console.log "STATES",Ship.State 
PhysicsObject.constructors.Ship = Ship
PhysicsObject.constructors.Bullet = Bullet 
exports.Ship = Ship
exports.Bullet = Bullet