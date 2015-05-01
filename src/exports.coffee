_ = require('lodash')

###
File to help detect the module.exports in a coffeescript file

Right now this is only capable of detecting one line exports

module.exports = foo
module.exports.foo = bar
exports.foo = bar

nothing like

module.exports.foo = (bar)->
  baz()

###

module.exports.is_export = is_export = (line) ->
  (/module.exports/.test(line) or /exports/.test(line)) and (line.indexOf("=>") is -1 and line.indexOf("->") is -1)
