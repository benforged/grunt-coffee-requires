grunt = require "grunt"
path  = require "path"

exports_tester = require "./exports"
requires_tester = require "./requires"

class RequiresTree
  constructor: (@src_file, @base_path) ->
    # grunt.file.setBase @base_path
    @tree = {}
    @order = []

  find_requires: (file_path) ->
    try
      contents = grunt.file.read(file_path)
    catch err
      throw new Error("Cannot read file #{file_path} - #{err}")
    lines = contents.split('\n')
    requires = []
    for line in lines
      if requires_tester.is_requires line
        module_name = requires_tester.module_name line
        unless !module_name? or path.extname(module_name) is '.js' or requires_tester.is_node_module(module_name)
          requires.push module_name
    return requires

  #  A depth first search from start
  dfs: (start) ->
    start = path.join(@base_path, start)
    current_dir = path.dirname(start)
    @tree[start] = true
    order = []
    dependencies = @find_requires(start)
    for dependency in dependencies
      dependency = path.join(current_dir, dependency)
      unless path.extname(dependency) is ".coffee"
        dependency += ".coffee"
      unless @tree[dependency]?
        order = [].concat order, @_dfs(dependency, path.dirname(dependency))
        order.push dependency
    return order

  #  dfs recursive helper function
  _dfs: (dependency, current_dir) ->
    @tree[dependency] = true
    order = []
    for node in @find_requires(dependency)
      node = path.join(current_dir, node)
      unless path.extname(node) is ".coffee"
        node += ".coffee"
      unless @tree[node]?
        order = [].concat order, @_dfs(node, path.dirname(node))
        order.push node
    return order
  

  compute: ->
    start = @src_file
    @dfs(start)

module.exports = RequiresTree
