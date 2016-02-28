'use strict';
import React from 'react';
import { render } from 'react-dom';

let Selection = require('./players-selection/selection'),
    GameProgress = require('./game-progress/game-progress');

const GameControl = React.createClass({
    getControlBasedOnStatus(){
        if(this.props.status === "not_started"){
            return <Selection players={this.props.players}
                              nextPlayer={this.props.nextPlayer}
                              playerToStart={this.props.playerToStart}
                              playerToStartSelected={this.props.playerToStartSelected}
                              typeSelected={this.props.typeSelected}
                              startGame={this.props.startGame}/>;
        }

        return <GameProgress players={this.props.players}
                             nextPlayer={this.props.nextPlayer}/>;
    },

    render() {
        return (
            <div>
                {this.getControlBasedOnStatus()}
            </div>
        );
    }
});

module.exports = GameControl;