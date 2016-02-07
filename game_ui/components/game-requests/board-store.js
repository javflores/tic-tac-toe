'use strict';
import Reflux from 'reflux';
let GameStartupStore = require('./game-startup-store');

const BoardStore = Reflux.createStore({
    init(){
        this.listenTo(GameStartupStore, 'onGameStart');
    },

    onGameStart(startup){
        this.trigger(startup.board);
    }
});

module.exports = BoardStore;