_ = require 'underscore'

coffeeRename = (destBase, destPath) ->
  destPath = destPath.replace 'src/',''
  destBase + destPath.replace /\.coffee$/, '.js'

module.exports = (grunt) ->

  filterGrunt = ->
    gruntFiles = require("matchdep").filterDev("grunt-*")
    _.reject gruntFiles, (x) -> x is 'grunt-cli'

  filterGrunt().forEach grunt.loadNpmTasks

  config =
    coffee:
      compile:
        options:
          sourceMap: true
        files: grunt.file.expandMapping(['src/**/*.coffee'], 'lib/', {rename: coffeeRename })

    shell:
      options:
        stdout: true
      npm_install:
        command: "npm install"

    release: {}
    env:
      test:
        NODE_ENV: "test"

    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
        src: ['test/**/*-tests.coffee']
    mochacov:
      options:
        coveralls:
          repoToken: "VsV5jRd7Wnx0yQKtT1I0bMUPiD78q8LpG"
        require: ['coffee-script/register','should']
      all: ['test/**/*-tests.coffee']
 
  config.watch =
      scripts:
        files: ['src/**/*.coffee']
        tasks: ['build']
        options:
          livereload: false

      tests:
        files: ['test/**/*.coffee']
        tasks: ['build']
        options:
          livereload: false

  grunt.initConfig config

  grunt.registerTask "install", [
    "shell:npm_install"
  ]

  grunt.registerTask "build", [
    'coffee'
    'test'
  ]

  grunt.registerTask "test", [
    'env:test'
    'mochaTest:test'
  ]

  grunt.registerTask "testandcoverage", [
    'env:test'
    'mochaTest:test'
    'mochacov'
  ]

  grunt.registerTask 'deploy', [
    'test'
    'release'
  ]

  grunt.registerTask 'default', ['build', 'watch']


