'use strict';
import React from 'react';
import { render } from 'react-dom';
let Message = require("../game-progress/message");
let PlayerSelection = require('./player-selection');
let PlayerSelectionControl = require('./player-selection-control');
let GameActions = require('../game-requests/game-actions');

const Selection = React.createClass({
    typeSelected(playerNumber, type){
        let typeIcon = (type === "human") ? "fa-user" : "fa-laptop";
        let players = this.state.players;
        let player = players[playerNumber];

        player.type = type;
        player.typeIcon = typeIcon;
        this.setState({
            players: players
        });
    },

    playerToStartSelected(player){
        this.setState({
            playerToStart: player
        });
    },

    startGame(){
        let players = this.state.players.map((player) => {
            return {
                type: player.type
            };
        });
        GameActions.start({
            players: players,
            firstPlayer: this.state.playerToStart
        });
    },

    getInitialState(){
        return {
            players: [{
                type: "human",
                typeIcon: "fa-user"
            }, {
                type: "computer",
                typeIcon: "fa-laptop"
            }],
            playerToStart: "O"
        };
    },

    render() {
        return (
            <div className="row">
                <div className="row">
                    <Message message={"Select type of players and player that goes first"}/>
                </div>

                <div className="row">
                    <PlayerSelection player={this.state.players[0]}
                                     isPlayerToStart={this.state.playerToStart === "O"}
                                     playerToStartSelected={this.playerToStartSelected.bind(this, "O")}
                                     typeSelected={this.typeSelected.bind(this, 0)}/>

                    <div className="col-lg-4 col-sm-4 control">
                        <h5 className="subheader prompt">{"Select players type"}</h5>
                        <h5 className="subheader prompt">{"Click player going first"}</h5>
                        <h5 className="subheader prompt">{"Check to start game"}</h5>

                        <PlayerSelectionControl controlClicked={this.startGame} />
                    </div>

                    <PlayerSelection player={this.state.players[1]}
                                     isPlayerToStart={this.state.playerToStart === "X"}
                                     playerToStartSelected={this.playerToStartSelected.bind(this, "X")}
                                     typeSelected={this.typeSelected.bind(this, 1)}/>
                </div>
            </div>
        );
    }
});

module.exports = Selection;