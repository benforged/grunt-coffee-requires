(function() {
  var Animal, Cat, Dog, bar, baz_main, foo,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Animal = (function() {
    Animal = (function() {
      function Animal() {
        return this;
      }

      return Animal;

    })();
    return Animal;
  })();

  baz_main = (function() {
    return baz_main;
  })();

  Dog = (function() {
    Dog = (function(_super) {
      __extends(Dog, _super);

      function Dog() {
        this.name = baz;
        return this;
      }

      return Dog;

    })(Animal);
    return Dog;
  })();

  Cat = (function() {
    Cat = (function(_super) {
      __extends(Cat, _super);

      function Cat() {
        return this;
      }

      return Cat;

    })(Animal);
    return Cat;
  })();

  bar = (function() {
    var foo;
    foo = function(hat) {
      var cat, dog;
      cat = new Cat(hat);
      dog = new Dog(hat);
    };
    return bar;
  })();

  foo = (function() {
    var foobar;
    foobar = function(hat) {
      console.log(hat);
    };
    return foo;
  })();

}).call(this);
