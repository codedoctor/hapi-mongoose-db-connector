_ = require 'underscore'
Hoek = require "hoek"
mongoose = require 'mongoose'

Mixed = mongoose.Schema.Types.Mixed
ObjectId = mongoose.Schema.Types.ObjectId

module.exports.register = (server, options = {}, cb) ->
  defaults =
    mongodbUrl: null
    mongoOptions: {}

  options = Hoek.applyToDefaults defaults, options

  Hoek.assert options.mongodbUrl, 'Missing required mongodbUrl property in options.'

  startDb = ->
    server.log ['plugin', 'info','hapi-mongoose-db-connector'], "Mongoose connecting to #{options.mongodbUrl}"
    mongoose.connect options.mongodbUrl,options.mongoOptions, (err) ->
      if err
        server.log ['plugin', 'error','fatal','hapi-mongoose-db-connector'], "Mongoose connection failure"
      else
        server.log ['plugin', 'info','hapi-mongoose-db-connector'], "Mongoose connected to #{options.mongodbUrl}"

  stopDb = ->
    mongoose.disconnect()
  
  startDb()

  server.expose 'mongoose', mongoose

  server.expose 'start',startDb 
  server.expose 'stop',stopDb

  ###
  Obsolete commands - will be removed eventually
  ###
  server.expose 'mongooseStartDb',startDb 
  server.expose 'mongooseStopDb',stopDb

  cb()

module.exports.register.attributes =
    pkg: require '../package.json'
