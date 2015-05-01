#
# * grunt-coffee-requires
# * https://github.com/MarkForged/grunt-coffee-requires
# *
# * Copyright (c) 2014 David Benhaim
# * Licensed under the MIT license.
# 

{compile} = require 'coffee-script'
path = require "path"

BrowserStripper = require "../src/browser_stripper"
RequiresTree = require('../src/requires_tree')

module.exports = (grunt) ->
  
  # Please see the Grunt documentation for more information regarding task
  # creation: http://gruntjs.com/creating-tasks
  grunt.registerMultiTask "coffee_requires", "A grunt plugin that concatenates and compiles a coffeescript project into javascript with node.js requires statements", ->
    
    # Merge task-specific and/or target-specific options with these defaults.
    options = @options(
      compile: true
      bare: false
      header: ""
      footer: ""
      delimiter: "\n"
    )

    # done = @async()
    unless @files.length is 1
      grunt.fail.fatal(new Error("Please specify only one root file - got #{@files.length}"))
    
    # Iterate over all specified file groups.
    @file = @files[0]
    
    unless @file.src.length is 1
      grunt.fail.fatal(new Error("Please specify only one root file - got #{@file.src.length}"))

    entry_point = @file.src[0]
    
    rt = new RequiresTree(path.basename(entry_point), path.dirname(path.resolve(entry_point)))
    dependencies = rt.compute()

    dependencies.push path.join(path.dirname(path.resolve(entry_point)), path.basename(entry_point))

    bs = new BrowserStripper dependencies, @file.dest, options
    bs.process()

    if options.compile and grunt.file.exists(@file.dest)
      src = grunt.file.read(@file.dest)
      try
        compiled = compile(src, {
          sourceMap: options.sourceMap
          bare: options.bare
        })
      catch e
        grunt.log.error("#{e.message}(file: #{@file.dest}, line: #{e.location.last_line + 1}, column: #{e.location.last_column})")
        throw e
      grunt.log.ok("Compiled #{@file.dest}")
      if options.sourceMap
        {js: compiled, v3SourceMap} = compiled
        v3SourceMap = JSON.parse(v3SourceMap)
        v3SourceMap.sourceRoot = path.relative(fileOutDir, cwd)
        v3SourceMap.file = path.basename(outFile)
        v3SourceMap.sources[0] = path.relative(cwd, file)
        v3SourceMap = JSON.stringify(v3SourceMap)
        compiled += "\n\n//@ sourceMappingURL=#{path.basename(outFile)}.map"
        grunt.file.write("#{@file.dest}.map", v3SourceMap)
        grunt.log.ok("File #{@file.dest}.map was created")
      grunt.file.write(@file.dest, compiled)
      grunt.log.ok("File #{@file.dest} was created")

    return

  return