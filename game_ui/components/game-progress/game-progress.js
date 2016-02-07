'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let Player = require("./player");
let GameStartPlayersStore = require("../game-requests/game-start-players-store");

const GameProgress = React.createClass({
    onPlayersReady(startPlayers){
        this.setState({
            players: startPlayers.players
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
            }]
        };
    },

    mixins: [Reflux.listenTo(GameStartPlayersStore, 'onPlayersReady')],

    render() {
        return (
            <div className="row">
                <Player player={this.state.players[0]}/>
                <Player player={this.state.players[1]}/>
            </div>
        );
    }
});

module.exports = GameProgress;