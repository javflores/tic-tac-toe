'use strict';
import React from 'react';
import { render } from 'react-dom';

let Player = require("./player");
let Message = require("./message");
let TurnIndicator = require("./turn-indicator");

const GameProgress = React.createClass({
    render() {
        return (
            <div className="row">
                <Message message={"The Game has started!"}/>
                <Player mark={"O"} player={this.props.players[0]} nextPlayer={this.props.nextPlayer}/>
                <TurnIndicator nextPlayer={this.props.nextPlayer}/>
                <Player mark={"X"} player={this.props.players[1]} nextPlayer={this.props.nextPlayer}/>
            </div>
        );
    }
});

module.exports = GameProgress;