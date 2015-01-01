(function() {
  var Hoek, Mixed, ObjectId, mongoose, _;

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
      mongodbUrl: null
    };
    options = Hoek.applyToDefaults(defaults, options);
    Hoek.assert(options.mongodbUrl, 'Missing required mongodbUrl property in options.');
    startDb = function() {
      server.log(['plugin', 'info'], "Mongoose connecting to " + options.mongodbUrl);
      return mongoose.connect(options.mongodbUrl, function(err) {
        if (err) {
          return server.log(['plugin', 'error', 'fatal'], "Mongoose connection failure");
        } else {
          return server.log(['plugin', 'info'], "Mongoose connected to " + options.mongodbUrl);
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
