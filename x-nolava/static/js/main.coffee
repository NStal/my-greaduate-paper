SharedSettings = require("sharedSettings").SharedSettings
console.log SharedSettings
class Game extends Leaf.Widget
    constructor:()->
        super("#scene")
        @displayer = new Displayer()
        @world = new World()
        @username = window.location.hash.replace "#",""
    start:(serverWs)->
        serverWs = new WebSocketTunnel(serverWs)
        @server = new ServerInterface(serverWs)
        @serverHandler = new ServerHandler(serverWs)
        start = Date.now()
        @displayer.setWorld(@world)
        @displayer.setup() 
        #@displayer.camera.follow(@ship)
        #@world.add(@ship)
        @server.getServerTime (err,time)=>
            console.log "server time synced"
            Date.serverDeviation = time - (Date.now()+start)/2
            @server.enterGame @username,(err,sid)=>
                console.log "using ship id",sid
                if not err
                    console.log "game entered"
                    @server.completeSync (err,data)=>
                        console.log "complete synced",data
                        @world.init data
                        @userShip = @world.getObjectById sid
                        # console.assert userShip
                        if @userShip 
                            @displayer.camera.follow(@userShip)
                        else
                            console.warn "user ship not found."
                            console.warn "fail to set camera follow object."
                            return
                else 
                    console.trace()
                    console.log err
        @timer = setInterval (()=>
            @world.update()
            @displayer.update()
            Static.KM.solve()
            ),1000/SharedSettings.frameRate 
    setupTime:(callback)->
        console.log "setup time..."
    doCompleteSync: ->
        @server.sync (err,data)->
            if err
                console.error err
                console.trace()
                return
            @world.init data.objects
$ ()->
    Static.resourceManager =  new ResourceManager();
    Static.resourceManager.useObject "maid"
    Static.resourceManager.useObject "Spaceship"
    Static.resourceManager.useObject "missile"
    Static.resourceManager.on "ready",()->
        Static.resourceManager.preprocess()
        Static.KM = new Static.KeyMaster()
        Static.game = new Game()
        console.log "every thing ready,connect to server"
        ws = new WebSocket("ws://#{SharedSettings.serverHost}:#{SharedSettings.serverPort}")
        ws.onopen = ()->
            Static.game.start(ws)
        

