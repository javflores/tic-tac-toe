'use strict';
import React from 'react';
import { render } from 'react-dom';
let Message = require("../game-progress/message");
let PlayerSelection = require('./player-selection');
let PlayerSelectionControl = require('./player-selection-control');

const Selection = React.createClass({
    typeSelected(playerNumber, type){
        this.props.typeSelected(playerNumber, type);
    },

    playerToStartSelected(player){
        this.props.playerToStartSelected(player);
    },

    render() {
        return (
            <div className="row">
                <div className="row">
                    <Message message={"Select type of players and player that goes first"}/>
                </div>

                <div className="row">
                    <PlayerSelection player={this.props.players[0]}
                                     isPlayerToStart={this.props.playerToStart === "O"}
                                     playerToStartSelected={this.playerToStartSelected.bind(this, "O")}
                                     typeSelected={this.typeSelected.bind(this, 0)}/>

                    <div className="col-lg-4 col-sm-4 control">
                        <h5 className="subheader prompt">{"Select players type"}</h5>
                        <h5 className="subheader prompt">{"Click player going first"}</h5>
                        <h5 className="subheader prompt">{"Check to start game"}</h5>

                        <PlayerSelectionControl controlClicked={this.props.startGame} />
                    </div>

                    <PlayerSelection player={this.props.players[1]}
                                     isPlayerToStart={this.props.playerToStart === "X"}
                                     playerToStartSelected={this.playerToStartSelected.bind(this, "X")}
                                     typeSelected={this.typeSelected.bind(this, 1)}/>
                </div>
            </div>
        );
    }
});

module.exports = Selection;