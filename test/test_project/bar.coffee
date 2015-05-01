_ = require "lodash"
grunt = require "grunt"

Dog = require "./baz/dog/Dog"
Cat = require "./baz/cat/Cat"

foo = (hat)->
  cat = new Cat hat
  dog = new Dog hat
  return

exports.foo = foo