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

exports_test = require('../src/exports')

positives = [
  "exports.bar = bar"
  "module.exports.bar = foo"
  "module.exports = bar"
  "exports = bar"
]

negatives = [
  "exports.bar = bar = ()->"
  "module.exports.bar = ()->"
  "exports.bar = bar = ()=>"
  "module.exports.bar = ()=>"
  "exports.bar = bar = () ->"
  "module.exports.bar = () ->"
  "exports.bar = bar = () =>"
  "module.exports.bar = () =>"
  "exports.bar = bar = (foo)->"
  "module.exports.bar = (zing, bat)->"
  "exports.bar = bar = (doob)=>"
  "module.exports.bar = (smooby, dooby, doo)=>"
]

exports.exports_test =
  setUp: (done) ->
    # setup here if necessary
    done()
    return

  test: (test) ->
    test.expect 16
    
    for test_string in positives
        test.equal exports_test.is_export(test_string), true
    
    for test_string in negatives
        test.equal exports_test.is_export(test_string), false
    
    test.done()
    return