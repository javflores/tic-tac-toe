'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const CurrentMarkStore = Reflux.createStore({

    triggerCurrentMark(nextPlayer){
        let currentMark = (this.data.players[0].name === nextPlayer) ? "o" : "x";
        this.trigger(currentMark);
    },

    init(){
        this.listenToMany(GameActions);
    },

    data: {},

    onStartCompleted(startup){
        this.data.players = startup.players;
        this.triggerCurrentMark(startup.nextPlayer);
    },

    onMoveCompleted(move){
        this.triggerCurrentMark(move.nextPlayer);
    }

});

module.exports = CurrentMarkStore;