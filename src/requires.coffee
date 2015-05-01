_ = require('lodash')

requires_re_string = /require(\s"([^()'"]+)"|\s'([^()'"]+)'|\("([^()'"]+)"\)|\('([^()'"]+)'\))(?:\.?.*)?/

module.exports.is_requires = is_requires = (line) ->
  requires_re_string.test line

module.exports.module_name = module_name = (line)->
  results = line.match(requires_re_string)
  unless results?
    return null
  results = results.slice(2)
  for result in results
    return result if result?

module.exports.is_node_module = is_node_module = (module_name)->
  return module_name[0] isnt '.' and module_name[0] isnt '/'
