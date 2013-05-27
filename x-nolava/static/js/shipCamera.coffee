class ShipCamera  extends Three.PerspectiveCamera
    constructor:(fov,ratio,near,far)->
        Three.PerspectiveCamera.call(this,fov,ratio,near,far)
        @targetDistance = 3000
        @towards = new Three.Vector3(-0.5,0,0)
        @useQuaternion = true
        @position.set(0,0,3000)
    follow:(ship)->
        @target = ship
    update:()->
        if not @target
            return
        @towards.set(0,0.1,0.5)
        @towards.applyQuaternion(@target.quaternion)
        @towards.setLength(@targetDistance)
        @position.set(0,0,0)
        @position.add(@target.position)
        @position.add(@towards)
        @lookAt @target.position
        @quaternion.copy(@target.quaternion)

Static.ShipCamera = ShipCamera

