'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const GameStartPlayersStore = Reflux.createStore({
    init(){
        this.listenToMany(GameActions);
    },

    onStartCompleted(startup){
        let players = {
            players: startup.players,
            nextPlayer: startup.nextPlayer
        };
        this.trigger(players);
    }
});

module.exports = GameStartPlayersStore;