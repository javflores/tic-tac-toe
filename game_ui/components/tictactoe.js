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
    newGameState(){
        return {
            status: "not_started",
                type: "human_computer",
            players: [{
                type: "human"
            },{
                type: "computer"
            }],
            playerToStart: "O",
            nextPlayer: "O",
            board: [],
            winner: "",
            draw: false
        };
    },

    shouldTriggerComputerMove(nextPlayer, type, players){
        if (type !== "human_computer") {
            return false;
        }
        let nextPlayerType = (nextPlayer === "O") ? players[0].type : players[1].type;
        return nextPlayerType === "computer";
    },

    playerToStartSelected(player){
        this.setState({
            playerToStart: player
        });
    },

    typeSelected(playerNumber, type){
        let players = this.state.players;
        let player = players[playerNumber];
        player.type = type;
        this.setState({
            players: players
        });
    },

    startNewGame(){
        this.setState(this.newGameState());
    },

    repeatGame(){
        this.setState({
            winner: "",
            draw: false
        });

        GameActions.start({
            players: this.state.players,
            firstPlayer: this.state.playerToStart
        });
    },

    startGame(){
        GameActions.start({
            players: this.state.players,
            firstPlayer: this.state.playerToStart
        });
    },

    onStartCompleted(startup){
        this.setState({
            status: startup.status,
            type: startup.type,
            players: startup.players,
            nextPlayer: startup.nextPlayer,
            board: startup.board
        });

        if(this.shouldTriggerComputerMove(startup.nextPlayer, startup.type, startup.players)){
            GameActions.computerMove();
        }
    },

    onMoveCompleted(move){
        let nextPlayer = move.nextPlayer;
        let draw = move.status === "draw";
        let winner = (move.status === "winner") ? (move.player) : "";

        this.setState({
            status: move.status,
            nextPlayer: move.nextPlayer,
            board: move.board,
            draw: draw,
            winner: winner
        });

        if(this.shouldTriggerComputerMove(nextPlayer, this.state.type, this.state.players)){
            GameActions.computerMove();
        }
    },

    getInitialState: function() {
        return this.newGameState();
    },

    mixins: [Reflux.listenToMany(GameActions)],

    render() {
        return (
            <div>
                <GameOver winner={this.state.winner}
                          draw={this.state.draw}
                          repeatGame={this.repeatGame}
                          startNewGame={this.startNewGame}/>

                <Heading />

                <Board board={this.state.board}
                       gameType={this.state.type}
                       nextPlayer={this.state.nextPlayer}/>

                <GameControl status={this.state.status}
                             players={this.state.players}
                             nextPlayer={this.state.nextPlayer}
                             playerToStart={this.state.playerToStart}
                             playerToStartSelected={this.playerToStartSelected}
                             typeSelected={this.typeSelected}
                             startGame={this.startGame}/>
            </div>
        );
    }
});

module.exports = TicTacToe;