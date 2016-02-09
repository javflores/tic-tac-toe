'use strict';
import React from 'react';
import { render } from 'react-dom';

let Mark = require('./mark');

const Position = React.createClass({
    isPositionTaken(){
        return this.props.content === "o" || this.props.content === "x";
    },

    isPositionAvailable(){
        return this.props.content === null;
    },

    render() {
        let position = this.props.position,
            isAvailable = this.isPositionAvailable(),
            isTaken = this.isPositionTaken();

        if(isAvailable || isTaken){
            return (
                <Mark content={this.props.content} position={position} available={isAvailable}/>
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