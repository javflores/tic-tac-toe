'use strict';
import Reflux from 'reflux';
let GameStartupStore = require('./game-startup-store');

const GameStartPlayersStore = Reflux.createStore({
    init(){
        this.listenTo(GameStartupStore, 'onGameStart');
    },

    onGameStart(startup){
        let players = {
            players: startup.players,
            nextPlayer: startup.nextPlayer
        };
        this.trigger(players);
    }
});

module.exports = GameStartPlayersStore;