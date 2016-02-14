'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const GameTypeStore = Reflux.createStore({
    init(){
        this.listenTo(GameActions.start.completed, this.onStartCompleted);
    },

    onStartCompleted(startup){
        this.trigger(startup.type);
    }
});

module.exports = GameTypeStore;