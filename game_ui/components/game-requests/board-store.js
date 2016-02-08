'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const BoardStore = Reflux.createStore({
    init(){
        this.listenToMany(GameActions);
    },

    onStartCompleted(startup){
        this.trigger(startup.board);
    },

    onMoveCompleted(move){
        this.trigger(move.board);
    }
});

module.exports = BoardStore;