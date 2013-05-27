class KeyMaster extends Leaf.KeyEventManager
    constructor:()->
        super()
        @attachTo window
        @master()
        keys = ["up","down","right","left","space","w"]
        @Key = []
        @on "keydown",(e)=>
            for key in keys
                if Leaf.Key[key] is e.which
                    @Key[key] = true
                    break
        @on "keyup",(e)=>
            for key in keys
                if Leaf.Key[key] is e.which
                    @Key[key] = false
                    break
    solve:()->
        if not Static.game.userShip
            console.log "not user ship, so can't control"
            return
            
        state = (@Key.up and Ship.State.up or 0) |
            (@Key.left and Ship.State.left or 0) |
            (@Key.down and Ship.State.down or 0) |
            (@Key.right and Ship.State.right or 0) |
            (@Key.w and Ship.State.forward or 0) |
            (@Key.space and Ship.State.fire or 0)
        #console.log state,Static.game.userShip.state
        if state isnt Static.game.userShip.state
            Static.game.server.update state 
                

Static.KeyMaster = KeyMaster