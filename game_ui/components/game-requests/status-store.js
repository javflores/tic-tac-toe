'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const StatusStore = Reflux.createStore({
    init(){
        this.listenToMany(GameActions);
    },

    onStartCompleted(startup){
        this.trigger(startup.status);
    },

    onMoveCompleted(move){
        this.trigger(move.status)
    }
});

module.exports = StatusStore;