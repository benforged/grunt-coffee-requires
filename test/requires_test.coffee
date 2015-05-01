"use strict"
grunt = require("grunt")

#
#  ======== A Handy Little Nodeunit Reference ========
#  https://github.com/caolan/nodeunit
#
#  Test methods:
#    test.expect(numAssertions)
#    test.done()
#  Test assertions:
#    test.ok(value, [message])
#    test.equal(actual, expected, [message])
#    test.notEqual(actual, expected, [message])
#    test.deepEqual(actual, expected, [message])
#    test.notDeepEqual(actual, expected, [message])
#    test.strictEqual(actual, expected, [message])
#    test.notStrictEqual(actual, expected, [message])
#    test.throws(block, [error], [message])
#    test.doesNotThrow(block, [error], [message])
#    test.ifError(value)
#

require_test = require('../src/requires')

mock_data =
    "import = require(\"foobar\")" : "foobar"
    "import = require('foobar')": "foobar"
    "import = require(\"foobar\").foo": "foobar"
    "import = require('foobar').foo": "foobar"
    "import = require \"foobar\"": "foobar"
    "import = require 'foobar'": "foobar"

mock_files = 
    "import = require(\"./foo/bar\")" : "./foo/bar"
    "import = require('../foo/bar')": "../foo/bar"
    "import = require(\"../foo/bar\").foo": "../foo/bar"
    "import = require('../foo/bar').foo": "../foo/bar"
    "import = require \"../../../foo/bar\"": "../../../foo/bar"
    "import = require '../foo/bar'": "../foo/bar"

should_not_pass =
    "import = require('import\"": false

exports.requires_test =
  setUp: (done) ->
    # setup here if necessary
    done()
    return

  test: (test) ->
    test.expect 7
    for test_string of mock_data
        test.equal require_test.is_requires(test_string), true
    for invalid of should_not_pass
        test.equal require_test.is_requires(invalid), false
    test.done()
    return

  module_name: (test) ->
    test.expect 7

    for test_string, import_name of mock_data
        test.equal require_test.module_name(test_string), import_name
    
    for invalid of should_not_pass
        test.equal require_test.module_name(invalid), null
    
    test.done()
    return

  is_node_module_or_file: (test) ->
    test.expect 12

    for test_string, import_name of mock_data
        test.equal require_test.is_node_module(require_test.module_name(test_string)), true
    
    for test_string, import_name of mock_files
        test.equal require_test.is_node_module(require_test.module_name(test_string)), false
    
    test.done()
    return
