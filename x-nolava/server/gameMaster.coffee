require "coffee-script"
EventEmitter = (require "events").EventEmitter
PhysicsObject = (require "../common/physics").PhysicsObject
Ship = (require "../common/ship").Ship
Static = (require "./static").Static
class User
    constructor:(username,session)->
        @username = username
        @session = session
        @session.user = this
class GameMaster extends EventEmitter
    constructor:()->
        @users = []
        Static.world.on "add",(object)->
            data = object.toData() 
            for item in Static.server.sessions
                item.client.update(object.toData())
            object.on "fire",(bullet)->
                Static.world.add bullet
            object.on "explosion",(object)->
                #object.markRemove = true
                #console.log "after",Static.world.objects
                #object.state = Ship.State.explosion
                #for item in Static.server.sessions
                #    item.client.update Ship.State.explosion
    newUserEnterGame:(session,username)->
        user =  new User(username,session)
        createShip = false
        for item in Static.world.objects
            if item.user and item.user.username is username
                item.user = user
                user.ship = item
        if not user.ship
            createShip = true
            user.ship = new Ship({id:PhysicsObject.getNewId()})
        session.on "end",()=>
            console.log "end session"
            index = @users.indexOf(user)
            if index >= 0
                console.log "trim session"
                @users.splice(index,1)
        
        user.ship.user = user
        @users.push user
        if createShip
            Static.world.add user.ship 
        return user.ship.id
    update:(session,state)->
        if not session.user.ship
            console.error "User Dont Has An Ship"
            return null
        ship = session.user.ship
        if ship.state is state
            return true
        ship.state = state
        data = ship.toData()
        for item in Static.server.sessions
            item.client.update(data)
        return true
        
        
        
        
 exports.GameMaster = GameMaster