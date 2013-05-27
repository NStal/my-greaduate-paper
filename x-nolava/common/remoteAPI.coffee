rpc = require "../common/rpc"
RPCInterface = rpc.RPCInterface
RPCServer = rpc.RPCServer
# though using /server/ folder as required path
# but will also workd for browser
# not so graceful but works
# maybe fixed latter
Static = (require "../server/static").Static

class ClientInterface extends RPCInterface
    constructor:(ws)->
        super(ws)
        @declare "ticktock"
        @declare "update","information"
        return
class ClientHandler extends RPCServer
    constructor:(ws)->
        super(ws)
        @declare "getServerTime"
        @declare "enterGame"
        @declare "completeSync"
        @declare "update"
        return
    getServerTime:(callback)->
        callback null,Date.now()
    enterGame:(username,callback)->
        info = Static.gameMaster.newUserEnterGame(@session,username) 
        callback(null,info) 
    completeSync:(callback)->
        callback(null,Static.world.toData()) 
    update:(state,callback)-> 
        if not @session.user
            callback("Not enter game")
            return
        info = Static.gameMaster.update(@session,state)
        if not info
            callback("Fail to update")
            return 
        callback(null)
        
    
class ServerInterface extends RPCInterface
    constructor:(ws)->
        super(ws)
        @declare "getServerTime"
        @declare "enterGame" 
        @declare "completeSync"
        @declare "update"

        return
class ServerHandler extends RPCServer
    constructor:(ws)->
        super(ws)
        @declare "ticktock"
        @declare "update","information"
        return
    ticktock:(callback)->
        console.log "recieve server ticktock"
        callback(null,"")
    update:(info,callback)->
        Static.game.world.updateObject(info)
        callback(null)
    
exports.ClientHandler = ClientHandler
exports.ClientInterface = ClientInterface
exports.ServerInterface = ServerInterface
exports.ServerHandler = ServerHandler