# grunt-coffee-requires

> A grunt plugin that concatenates and compiles a coffeescript project into javascript with node.js requires statements'

## Getting Started
This plugin requires Grunt `~0.4.5`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-coffee-requires --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-coffee-requires');
```

## The "coffee_requires" task

### Overview
In your project's Gruntfile, add a section named `coffee_requires` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  coffee_requires: {
    options: {
      compile: true
      bare: false
      header: ""
      footer: ""
      delimiter: "\n"
    },
    your_target: {
      "output_file": "main_file"
    },
  },
});
```

### Options

#### options.compile
Type: `boolean`
Default value: `true`

Compile output to JavaScript or not

#### options.bare
Type: `boolean`
Default value: `false`

Compile the JavaScript without the top-level function safety wrapper.

#### options.header
Type: `String`
Default value: `""`

A string value that is inserted before all of the dependencies are concatenated but before compilation.

#### options.footer
Type: `String`
Default value: `""`

A string value that is inserted after all of the dependencies are concatenated but before compilation.

#### options.delimiter
Type: `String`
Default value: `\n`

A string value that is inserted between dependencies. 

### Usage Examples

#### Default Options
In the test example, the default options are used to convert ```test_project``` into one compiled file. 

```js
grunt.initConfig({
  coffee_requires: {
    default_options: {
      options: {
      },
      files: {
        'tmp/compiled_file.js': "test/test_project/main.coffee"
      }
    }
  }
});
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

## Release History
v0.0.0 - first release