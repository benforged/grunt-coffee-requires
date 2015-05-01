"use strict"
grunt = require "grunt"
path = require "path"
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

RequiresTree = require('../src/requires_tree')

test_project_order = [
    path.join(__dirname, "./test_project/baz/animal/Animal.coffee")
    path.join(__dirname, "./test_project/baz/baz_main.coffee")
    path.join(__dirname, "./test_project/baz/dog/Dog.coffee")
    path.join(__dirname, "./test_project/baz/cat/Cat.coffee")
    path.join(__dirname, "./test_project/bar.coffee")
    path.join(__dirname, "./test_project/foo.coffee")
]


exports.requires_test =
  setUp: (done) ->
    # setup here if necessary
    done()
    return

  test: (test) ->
    test.expect 6

    rt = new RequiresTree "./test_project/main.coffee", __dirname
    import_order = rt.compute()
    
    for dependency, i in import_order
        test.equal dependency, test_project_order[i]
    
    test.done()
    return
