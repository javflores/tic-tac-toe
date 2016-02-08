'use strict';
import Reflux from 'reflux';

const GameActions = Reflux.createActions(
    {
        'start': {children: ['completed']},
        'move': {children: ['completed']}
    }
);

module.exports = GameActions;