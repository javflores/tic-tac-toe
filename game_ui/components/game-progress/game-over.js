'use strict';
import React from 'react';
import { render } from 'react-dom';

let Winner = require ('./winner');
let Draw = require('./draw');

const GameOver = React.createClass({
    hasWinner(){
        return this.props.winner !== "";
    },

    isDraw(){
        return this.props.draw === true;
    },

    restartGame(option){
        (option === "repeat") ? this.props.repeatGame() : this.props.startNewGame();
    },

    render() {
        if(this.hasWinner()){
            return (
                <div className="winner">
                    <Winner winner={this.props.winner} restartGame={this.restartGame}/>
                </div>
            );
        }
        else if(this.isDraw()) {
            return (
                <div className="draw">
                    <Draw restartGame={this.restartGame}/>
                </div>
            );
        }

        else{
            return (
                <div></div>
            );
        }
    }
});

module.exports = GameOver;