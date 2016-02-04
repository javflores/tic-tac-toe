'use strict';
let Reflux = require('reflux');

const GameActions = Reflux.createActions(
    {
        'start': {children: ['completed']}
    }
);

module.exports = GameActions;