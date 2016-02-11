'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const ResultStore = Reflux.createStore({
    init(){
        this.listenTo(GameActions.move.completed, this.onMoveCompleted);
    },

    onMoveCompleted(move){
        if(move.status === "draw"){
            this.trigger({result: move.status});
        }
        if(move.status === "winner"){
            this.trigger({result: move.status, winner: move.player});
        }
    }
});

module.exports = ResultStore;