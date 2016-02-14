'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const NextPlayerStore = Reflux.createStore({
    init(){
        this.listenToMany(GameActions);
    },

    onStartCompleted(startup){
        this.trigger(startup.nextPlayer);
    },

    onMoveCompleted(move){
        let nextPlayer = move.nextPlayer;

        this.trigger(nextPlayer);
    }
});

module.exports = NextPlayerStore;