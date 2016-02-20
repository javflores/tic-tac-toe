'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const CurrentMarkStore = Reflux.createStore({
    getInitialState: function() {
        return this.data.currentMark;
    },

    init(){
        this.listenToMany(GameActions);
    },

    data: {},

    onStartCompleted(startup){
        this.data.currentMark = startup.nextPlayer;
        this.trigger(startup.nextPlayer);
    },

    onMoveCompleted(move){
        this.trigger(move.nextPlayer);
    }

});

module.exports = CurrentMarkStore;