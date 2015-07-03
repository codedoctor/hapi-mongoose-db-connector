(function() {
  var Hoek, Mixed, ObjectId, _, mongoose;

  _ = require('underscore');

  Hoek = require("hoek");

  mongoose = require('mongoose');

  Mixed = mongoose.Schema.Types.Mixed;

  ObjectId = mongoose.Schema.Types.ObjectId;

  module.exports.register = function(server, options, cb) {
    var defaults, startDb, stopDb;
    if (options == null) {
      options = {};
    }
    defaults = {
      mongodbUrl: null,
      mongoOptions: {}
    };
    options = Hoek.applyToDefaults(defaults, options);
    Hoek.assert(options.mongodbUrl, 'Missing required mongodbUrl property in options.');
    startDb = function() {
      server.log(['plugin', 'info', 'hapi-mongoose-db-connector'], "Mongoose connecting to " + options.mongodbUrl);
      return mongoose.connect(options.mongodbUrl, options.mongoOptions, function(err) {
        if (err) {
          return server.log(['plugin', 'error', 'fatal', 'hapi-mongoose-db-connector'], "Mongoose connection failure");
        } else {
          return server.log(['plugin', 'info', 'hapi-mongoose-db-connector'], "Mongoose connected to " + options.mongodbUrl);
        }
      });
    };
    stopDb = function() {
      return mongoose.disconnect();
    };
    startDb();
    server.expose('mongoose', mongoose);
    server.expose('start', startDb);
    server.expose('stop', stopDb);

    /*
    Obsolete commands - will be removed eventually
     */
    server.expose('mongooseStartDb', startDb);
    server.expose('mongooseStopDb', stopDb);
    return cb();
  };

  module.exports.register.attributes = {
    pkg: require('../package.json')
  };

}).call(this);

//# sourceMappingURL=index.js.map
