'use strict';

var Hapi = require('hapi'),
    Inert = require('inert');
var args = require('yargs')
    .default('port', 8000)
    .default('path', './lib')
    .argv;

var server = new Hapi.Server();

server.register(Inert, function () {
    server.connection({
        port: process.env.PORT || args.port
    });

    server.route({
        method: 'GET',
        path: '/{param*}',
        handler: {
            directory: {
                path: args.path,
                listing: true,
                index: true
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/node_modules/{param*}',
        handler: {
            directory: {
                path: 'node_modules'
            }
        }
    });
});

server.start(function () {
    console.log('Server started at port ' + server.info.port);
});