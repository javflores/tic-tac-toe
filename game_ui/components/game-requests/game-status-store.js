'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const GameStatusStore = Reflux.createStore({
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

module.exports = GameStatusStore;