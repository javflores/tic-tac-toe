'use strict';
import Reflux from 'reflux';
let GameStartupStore = require('./game-startup-store');

const CurrentMarkStore = Reflux.createStore({
    init(){
        this.listenTo(GameStartupStore, 'onGameStart');
    },

    onGameStart(startup){
        let currentMark = (startup.players[0].name === startup.nextPlayer) ? "o" : "x";
        this.trigger(currentMark);
    }
});

module.exports = CurrentMarkStore;