'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';
require('./game-requests/game-store');
let GameActions = require('./game-requests/game-actions');

let Heading = require('./heading'),
    Board = require('./board/board'),
    GameControl = require('./game-control'),
    GameOver = require('./game-progress/game-over');

const TicTacToe = React.createClass({
    shouldTriggerMove(nextPlayer, type, players){
        if (type !== "human_computer") {
            return false;
        }

        let nextPlayerType = players
            .filter((player) => player.name === nextPlayer)[0]
            .type;

        return nextPlayerType === "computer";
    },

    onStartCompleted(startup){
        if(this.shouldTriggerMove(startup.nextPlayer, startup.type, startup.players)){
            GameActions.computerMove();
        }
        this.setState({
            players: startup.players,
            type: startup.type
        });
    },

    onMoveCompleted(move){
        let nextPlayer = move.nextPlayer;

        if(this.shouldTriggerMove(nextPlayer, this.state.type, this.state.players)){
            GameActions.computerMove();
        }
    },

    mixins: [Reflux.listenToMany(GameActions)],

    render() {
        return (
            <div>
                <GameOver />
                <Heading />
                <Board />
                <GameControl />
            </div>
        );
    }
});

module.exports = TicTacToe;