// Generated by CoffeeScript 1.4.0
(function() {
  var EventEmitter, PhysicsObject, Quaternion, RK4, Three, Vector3, World,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Three = (require("../common/three-node.js")).THREE;

  Vector3 = Three.Vector3;

  Quaternion = Three.Quaternion;

  EventEmitter = (require("events")).EventEmitter;

  PhysicsObject = (function(_super) {

    __extends(PhysicsObject, _super);

    function PhysicsObject(data) {
      PhysicsObject.__super__.constructor.call(this);
      console.assert(data);
      if (typeof data.id === "number") {
        this.id = parseInt(data.id);
      } else if (typeof data.id === "string" && !isNaN(parseInt(data.id))) {
        this.id = parseInt(data.id);
      }
      this.mass = 1;
      this.minUpdates = 10;
      this.maxUpdates = 100;
      this.maxSpeed = 10;
      this.maxRotateSpeed = 1;
      this.updateProperties(data);
      this.constructor = data.constructor;
    }

    PhysicsObject.prototype.updateProperties = function(data) {
      var prop, _i, _len, _ref;
      console.assert(data);
      this.vector3s = ["position", "velocity", "rotateVelocity", "rotateAcceleration", "force"];
      _ref = this.vector3s;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        prop = _ref[_i];
        if (!this[prop]) {
          this[prop] = new Vector3;
        }
        if (data[prop]) {
          this[prop].copy(data[prop]);
        }
      }
      if (!this.quaternion) {
        this.quaternion = new Quaternion();
      }
      if (data.quaternion) {
        return this.quaternion.copy(data.quaternion);
      }
    };

    PhysicsObject.prototype.toData = function() {
      return {
        id: this.id,
        constructor: "PhysicsObject",
        position: {
          x: this.position.x,
          y: this.position.y,
          z: this.position.z
        },
        force: {
          x: this.force.x,
          y: this.force.y,
          z: this.force.z
        },
        rotateAcceleration: {
          x: this.rotateAcceleration.x,
          y: this.rotateAcceleration.y,
          z: this.rotateAcceleration.z
        },
        rotateVelocity: {
          x: this.rotateVelocity.x,
          y: this.rotateVelocity.y,
          z: this.rotateVelocity.z
        },
        velocity: {
          x: this.velocity.x,
          y: this.velocity.y,
          z: this.velocity.z
        },
        quaternion: {
          x: this.quaternion.x,
          y: this.quaternion.y,
          z: this.quaternion.z,
          w: this.quaternion.w
        }
      };
    };

    PhysicsObject.prototype.updatePhysics = function(deltaTime) {
      var prop, rotation, rotationQuaternion, _fn, _i, _len, _ref,
        _this = this;
      while (deltaTime > this.maxUpdates) {
        this.updatePhysics(this.maxUpdates);
        deltaTime -= this.maxUpdates;
      }
      console.assert(deltaTime >= 0);
      _ref = ["x", "y", "z"];
      _fn = function(prop) {
        _this.position[prop] += RK4(deltaTime, function(t) {
          return _this.velocity[prop] + t * _this.force[prop] / _this.mass;
        });
        return _this.velocity[prop] += deltaTime * _this.force[prop] / _this.mass;
      };
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        prop = _ref[_i];
        _fn(prop);
      }
      if (this.velocity.length() > this.maxSpeed) {
        this.velocity.normalize();
        this.velocity.multiplyScalar(this.maxSpeed);
      }
      rotation = this.rotateVelocity.clone().multiplyScalar(deltaTime / 1000);
      rotationQuaternion = new Quaternion().setFromEuler(rotation);
      this.quaternion.multiply(rotationQuaternion);
      this.rotateVelocity.add(this.rotateAcceleration);
      this.rotateVelocity.multiplyScalar(Math.pow(0.3, deltaTime / 1000));
      if (this.rotateVelocity.length() > this.maxRotateSpeed) {
        return this.rotateVelocity.normalize().multiplyScalar(this.maxRotateSpeed);
      }
    };

    PhysicsObject.prototype.update = function(time) {
      return this.updatePhysics(time);
    };

    return PhysicsObject;

  })(EventEmitter);

  PhysicsObject.UsedId = 1;

  PhysicsObject.getNewId = function() {
    var id;
    id = PhysicsObject.UsedId;
    PhysicsObject.UsedId += 1;
    return id;
  };

  PhysicsObject.constructors = {};

  World = (function(_super) {

    __extends(World, _super);

    function World() {
      World.__super__.constructor.call(this);
      this.objects = [];
      this.toRemove = [];
    }

    World.prototype.update = function() {
      var delta, index, object, time, _i, _j, _len, _len1, _ref, _ref1;
      time = Date.now();
      if (!this.lastUpdate) {
        this.lastUpdate = time;
      }
      delta = time - this.lastUpdate;
      this.lastUpdate = time;
      _ref = this.objects;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        object = _ref[index];
        object.update(delta);
        if (object.hitCheck) {
          object.hitCheck(this.objects, delta);
        }
        if (object.markRemove) {
          this.toRemove.push(object);
        }
      }
      _ref1 = this.toRemove;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        object = _ref1[_j];
        this.remove(object);
      }
      return this.toRemove.length = 0;
    };

    World.prototype.updateObject = function(obj) {
      var item, object;
      if (!this.inited) {
        return;
      }
      console.assert(obj);
      console.assert(obj.id);
      item = this.getObjectById(obj.id);
      if (!item) {
        object = this.createObject(obj);
        return this.add(object);
      } else {
        return item.updateProperties(obj);
      }
    };

    World.prototype.createObject = function(object) {
      var constructor;
      constructor = PhysicsObject.constructors[object.constructor];
      return new constructor(object);
    };

    World.prototype.init = function(objects) {
      var object, _i, _len, _results;
      this.inited = true;
      console.assert(objects);
      this.clear();
      _results = [];
      for (_i = 0, _len = objects.length; _i < _len; _i++) {
        object = objects[_i];
        object = this.createObject(object);
        _results.push(this.add(object));
      }
      return _results;
    };

    World.prototype.add = function(object) {
      console.assert(object instanceof PhysicsObject);
      this.objects.push(object);
      return this.emit("add", object);
    };

    World.prototype.clear = function() {
      return this.objects.length = 0;
    };

    World.prototype.remove = function(target) {
      var index, object, _i, _len, _ref;
      _ref = this.objects;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        object = _ref[index];
        if (object.id === target.id) {
          this.objects.splice(index, 1);
          this.emit("remove", object);
          return true;
        }
      }
      return false;
    };

    World.prototype.toData = function() {
      var item;
      return (function() {
        var _i, _len, _ref, _results;
        _ref = this.objects;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          _results.push(item.toData());
        }
        return _results;
      }).call(this);
    };

    World.prototype.getObjectById = function(id) {
      var object, _i, _len, _ref;
      console.assert(id);
      _ref = this.objects;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        object = _ref[_i];
        if (object.id === id) {
          return object;
        }
      }
      return null;
    };

    return World;

  })(EventEmitter);

  RK4 = function(delta, xFunc) {
    var k1, k2, k3, k4, y1;
    k1 = delta * xFunc(0);
    k2 = delta * xFunc(0 + delta / 2);
    k3 = delta * xFunc(0 + delta / 2);
    k4 = delta * xFunc(0 + delta);
    y1 = k1 / 6 + k2 / 3 + k3 / 3 + k4 / 6;
    return y1;
  };

  exports.PhysicsObject = PhysicsObject;

  exports.World = World;

}).call(this);
