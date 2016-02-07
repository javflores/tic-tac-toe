'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let Player = require("./player");
let Message = require("./message");
let TurnIndicator = require("./turn-indicator");
let GameStartPlayersStore = require("../game-requests/game-start-players-store");

const GameProgress = React.createClass({
    onPlayersReady(startPlayers){
        this.setState({
            players: startPlayers.players,
            nextPlayer: startPlayers.nextPlayer
        });
    },

    getInitialState(){
        return {
            players: [{
                name: "",
                type: ""
            },{
                name: "",
                type: ""
            }],
            nextPlayer: ""
        };
    },

    mixins: [Reflux.listenTo(GameStartPlayersStore, 'onPlayersReady')],

    render() {
        return (
            <div className="row">
                <Message />
                <Player player={this.state.players[0]} nextPlayer={this.state.nextPlayer}/>
                <TurnIndicator nextPlayer={this.state.nextPlayer}/>
                <Player player={this.state.players[1]} nextPlayer={this.state.nextPlayer}/>
            </div>
        );
    }
});

module.exports = GameProgress;