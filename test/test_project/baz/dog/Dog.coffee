Animal = require "../animal/Animal"
baz = require "../baz_main"

class Dog extends Animal
  constructor: ()->
    @name = baz
    return @

module.exports = Dog