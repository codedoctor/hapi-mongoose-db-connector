index = require '../../lib/index'
Hapi = require "hapi"
_ = require 'underscore'

module.exports = loadServer = (cb) ->
    ###
    @NOTE This should be taken out of env vars, set in the  grunt file, as an env setting, but hey, we have too much work to do right now.
    ###

    server = new Hapi.Server()
    server.connection 
                port: 5675
                host: "localhost"

    pluginConf = [
        register: index
        options: 
          mongodbUrl: "mongodb://localhost/codedoctor-test"
    ]

    server.register pluginConf, (err) ->
      cb err,server