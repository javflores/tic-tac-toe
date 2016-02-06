'use strict';
import Reflux from 'reflux';
let GameStartupStore = require('./game-startup-store');

const GameStatusStore = Reflux.createStore({
    init(){
        this.listenTo(GameStartupStore, 'onGameStart');
    },

    onGameStart(startup){
        this.trigger(startup.status);
    }
});

module.exports = GameStatusStore;