'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const NextPlayerStore = Reflux.createStore({
    isStillInProgress(status){
        return status !== "draw" && status !== "win";
    },

    init(){
        this.listenToMany(GameActions);
    },

    onStartCompleted(startup){
        this.trigger(startup.nextPlayer);
    },

    onMoveCompleted(move){
        if(this.isStillInProgress(move.status)){
            let nextPlayer = move.nextPlayer;

            this.trigger(nextPlayer);
        }
    }
});

module.exports = NextPlayerStore;