[![Build Status](https://travis-ci.org/codedoctor/hapi-mongoose-db-connector.svg?branch=master)](https://travis-ci.org/codedoctor/hapi-mongoose-db-connector)
[![Coverage Status](https://img.shields.io/coveralls/codedoctor/hapi-mongoose-db-connector.svg)](https://coveralls.io/r/codedoctor/hapi-mongoose-db-connector)
[![NPM Version](http://img.shields.io/npm/v/hapi-mongoose-db-connector.svg)](https://www.npmjs.org/package/hapi-mongoose-db-connector)
[![Dependency Status](https://gemnasium.com/codedoctor/hapi-mongoose-db-connector.svg)](https://gemnasium.com/codedoctor/hapi-mongoose-db-connector)
[![NPM Downloads](http://img.shields.io/npm/dm/hapi-mongoose-db-connector.svg)](https://www.npmjs.org/package/hapi-mongoose-db-connector)
[![Issues](http://img.shields.io/github/issues/codedoctor/.svg)](https://github.com/codedoctor/hapi-mongoose-db-connector/issues)
[![HAPI 6.0](http://img.shields.io/badge/hapi-6.0-blue.svg)](http://hapijs.com)
[![API Documentation](http://img.shields.io/badge/API-Documentation-ff69b4.svg)](http://coffeedoc.info/github/codedoctor/hapi-mongoose-db-connector)


(C) 2014 Martin Wawrusch

HAPI module to connect to mongodb (using mongoose).

## Rational
When creating services with HAPI a working design approach is to split functionality into individual plugins, which can be individually tested and developed. To facilitate this, this plugin provides the functionality to connect and disconnect from a mongodb through mongoose.

To use it you include it into your server configuration like so:

```coffeescript
hapiMongooseDbConnector = require 'hapi-mongoose-db-connector'

server = new Hapi.Server 3000, "localhost", {}

pluginConf = [
    plugin: hapiMongooseDbConnector
    options:
      mongodbUrl: "your mongodb url."
    #... more plugins
]

server.pack.register pluginConf, (err) ->
  throw err if err

```

Now this automatically connects to mongodb when the server starts.

## How to access mongoose
There are basically two ways of doing this:

### The bad way
You reference this plugin and access the mongoose property exposed by the plugin. This creates some nasty runtime dependencies that you don't want.

```coffeescript
# from the server
mongoose = server.pack.plugins['hapi-mongoose-db-connector'].mongoose
# or from a plugin
mongoose = plugin.plugins['hapi-mongoose-db-connector'].mongoose
```

### The good way
You do nothing and just require mongoose in your plugins. As npm requires are singletons (the code is loaded only once this works very well)

## See also

* [hapi-auth-bearer-mw](https://github.com/codedoctor/hapi-auth-bearer-mw)
* [hapi-loggly](https://github.com/codedoctor/hapi-loggly)
* [hapi-mandrill](https://github.com/codedoctor/hapi-mandrill)
* [hapi-mongoose-db-connector](https://github.com/codedoctor/hapi-mongoose-db-connector)
* [hapi-oauth-store-multi-tenant](https://github.com/codedoctor/hapi-oauth-store-multi-tenant)
* [hapi-routes-authorization-and-session-management](https://github.com/codedoctor/hapi-routes-authorization-and-session-management)
* [hapi-routes-oauth-management](https://github.com/codedoctor/hapi-routes-oauth-management)
* [hapi-routes-roles](https://github.com/codedoctor/hapi-routes-roles)
* [hapi-routes-status](https://github.com/codedoctor/hapi-routes-status)
* [hapi-routes-users-authorizations](https://github.com/codedoctor/hapi-routes-users-authorizations)
* [hapi-routes-users](https://github.com/codedoctor/hapi-routes-users)
* [hapi-user-store-multi-tenant](https://github.com/codedoctor/hapi-user-store-multi-tenant)

and additionally

* [api-pagination](https://github.com/codedoctor/api-pagination)
* [mongoose-oauth-store-multi-tenant](https://github.com/codedoctor/mongoose-oauth-store-multi-tenant)
* [mongoose-rest-helper](https://github.com/codedoctor/mongoose-rest-helper)
* [mongoose-user-store-multi-tenant](https://github.com/codedoctor/mongoose-user-store-multi-tenant)

## Contributing
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the package.json, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Martin Wawrusch 
