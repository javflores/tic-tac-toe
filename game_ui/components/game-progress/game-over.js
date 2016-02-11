'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let Winner = require ('./winner');
let Draw = require('./draw');
let ResultStore = require("../game-requests/result-store");

const GameOver = React.createClass({
    onResultCompleted(gameEnd){
        if(gameEnd.result === "draw"){
            this.setState({
                draw: true
            });
        }

        else{
            this.setState({
                winner: gameEnd.winner
            });
        }
    },

    hasWinner(){
        return this.state.winner !== "";
    },

    isDraw(){
        return this.state.draw === true;
    },

    restartGame(){
        window.location.reload()
    },

    getInitialState: function() {
        return {
            winner: "",
            draw: false
        };
    },

    mixins: [Reflux.listenTo(ResultStore, "onResultCompleted")],

    render() {
        if(this.hasWinner()){
            return (
                <div className="winner">
                    <Winner winner={this.state.winner} restartGame={this.restartGame}/>
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