// Generated by CoffeeScript 1.4.0
(function() {
  var EventEmitter, GameMaster, PhysicsObject, Ship, Static, User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  require("coffee-script");

  EventEmitter = (require("events")).EventEmitter;

  PhysicsObject = (require("../common/physics")).PhysicsObject;

  Ship = (require("../common/ship")).Ship;

  Static = (require("./static")).Static;

  User = (function() {

    function User(username, session) {
      this.username = username;
      this.session = session;
      this.session.user = this;
    }

    return User;

  })();

  GameMaster = (function(_super) {

    __extends(GameMaster, _super);

    function GameMaster() {
      this.users = [];
      Static.world.on("add", function(object) {
        var data, item, _i, _len, _ref;
        data = object.toData();
        _ref = Static.server.sessions;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          item.client.update(object.toData());
        }
        object.on("fire", function(bullet) {
          return Static.world.add(bullet);
        });
        return object.on("explosion", function(object) {});
      });
    }

    GameMaster.prototype.newUserEnterGame = function(session, username) {
      var createShip, item, user, _i, _len, _ref,
        _this = this;
      user = new User(username, session);
      createShip = false;
      _ref = Static.world.objects;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (item.user && item.user.username === username) {
          item.user = user;
          user.ship = item;
        }
      }
      if (!user.ship) {
        createShip = true;
        user.ship = new Ship({
          id: PhysicsObject.getNewId()
        });
      }
      session.on("end", function() {
        var index;
        console.log("end session");
        index = _this.users.indexOf(user);
        if (index >= 0) {
          console.log("trim session");
          return _this.users.splice(index, 1);
        }
      });
      user.ship.user = user;
      this.users.push(user);
      if (createShip) {
        Static.world.add(user.ship);
      }
      return user.ship.id;
    };

    GameMaster.prototype.update = function(session, state) {
      var data, item, ship, _i, _len, _ref;
      if (!session.user.ship) {
        console.error("User Dont Has An Ship");
        return null;
      }
      ship = session.user.ship;
      if (ship.state === state) {
        return true;
      }
      ship.state = state;
      data = ship.toData();
      _ref = Static.server.sessions;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        item.client.update(data);
      }
      return true;
    };

    return GameMaster;

  })(EventEmitter);

  exports.GameMaster = GameMaster;

}).call(this);