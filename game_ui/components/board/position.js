'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let GameTypeStore = require("../game-requests/game-type-store");
let Mark = require('./mark');

const Position = React.createClass({
    isPositionTaken(){
        return this.props.content === "o" || this.props.content === "x";
    },

    isPositionAvailable(){
        return this.props.content === null;
    },

    getInitialState(){
        return {
            gameType: "human_computer"
        };
    },

    mixins: [Reflux.connect(GameTypeStore, 'gameType')],

    render() {
        let position = this.props.position,
            isAvailable = this.isPositionAvailable(),
            isTaken = this.isPositionTaken();

        if(isAvailable || isTaken){
            return (
                <Mark content={this.props.content} position={position} available={isAvailable} gameType={this.state.gameType}/>
            );
        }

        else{
            return (
                <div>
                </div>
            );
        }
    }
});

module.exports = Position;