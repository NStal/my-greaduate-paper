EventEmitter = (require "events").EventEmitter
class extends EventEmitter
    constructor:()->
        @world = new World()
    init:()->
        
    update:(info)->
        #unsafe methos
        # used to update objects state
        