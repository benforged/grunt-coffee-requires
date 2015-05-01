_ = require "lodash"
fs = require "fs"
grunt = require "grunt"
path = require "path"

exports_tester = require "./exports"
requires_tester = require "./requires"

class BrowserStripper
  constructor: (@files, @output_file, options={}) ->
    defaults = 
      delimiter: "\n"
      indentation: "  "
    @options = _.defaults(options, defaults)
    grunt.file.mkdir(path.dirname(@output_file))

  open_file: ->
    @fd = fs.openSync @output_file, 'w'

  close_file: ->
    fs.closeSync @fd

  write_header: ->
    fs.writeSync(@fd, @options.header+"\n")

  write_footer: ->
    fs.writeSync(@fd,  @options.footer+"\n")

  write_data: (data)->
    fs.writeSync(@fd, data)

  process: ->
    @open_file()
    if @options.header?
      @write_header()
    for file, i in @files
      @process_file(file)
      if @options.delimiter? and i != @files.length - 1
        @write_data @options.delimiter
    if @options.footer?
      @write_footer()
    @close_file()
    return

  process_file: (file_path)->
    try
      contents = grunt.file.read(file_path)
    catch err
      throw new Error("Cannot read file #{file_path} - #{err}")
    
    lines = contents.split('\n')
    output = []
    
    has_exports = false

    for line in lines
      if exports_tester.is_export(line)
        has_exports = true
        continue
      unless requires_tester.is_requires(line)
        output.push line

    if has_exports
      output = "  " + output.join "\n  "
      class_name = path.basename file_path, ".coffee"
      open_closure = "#{class_name} = (()->\n"
      close_closure = "\n  return #{class_name})()"
      output = open_closure + output + close_closure
    else
      output = output.join "\n"

    @write_data output
    return

module.exports = BrowserStripper