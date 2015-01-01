_ = require 'underscore'
Hoek = require "hoek"
mongoose = require 'mongoose'

Mixed = mongoose.Schema.Types.Mixed
ObjectId = mongoose.Schema.Types.ObjectId

module.exports.register = (server, options = {}, cb) ->
  defaults =
    mongodbUrl: null

  options = Hoek.applyToDefaults defaults, options

  Hoek.assert options.mongodbUrl, 'Missing required mongodbUrl property in options.'


  startDb = ->
    server.log ['plugin', 'info'], "Mongoose connecting to #{options.mongodbUrl}"
    mongoose.connect options.mongodbUrl, (err) ->
      if err
        server.log ['plugin', 'error','fatal'], "Mongoose connection failure"
      else
        server.log ['plugin', 'info'], "Mongoose connected to #{options.mongodbUrl}"

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
