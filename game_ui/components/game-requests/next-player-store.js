'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');

const NextPlayerStore = Reflux.createStore({
    shouldTriggerMove(nextPlayer){
        if (this.data.type !== "human_computer") {
            return false;
        }

        let nextPlayerType = this.data.players
            .filter((player) => player.name === nextPlayer)[0]
            .type;

        return nextPlayerType === "computer";
    },

    data:{},

    init(){
        this.listenToMany(GameActions);
    },

    onStartCompleted(startup){
        this.data.players = startup.players;
        this.data.type = startup.type;

        this.trigger(startup.nextPlayer);
    },

    onMoveCompleted(move){
        let nextPlayer = move.nextPlayer;

        this.trigger(nextPlayer);

        if(this.shouldTriggerMove(nextPlayer)){
            GameActions.computerMove();
        }
    }
});

module.exports = NextPlayerStore;