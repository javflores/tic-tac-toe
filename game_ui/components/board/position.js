'use strict';
import React from 'react';
import { render } from 'react-dom';

let Mark = require('./mark');

const Position = React.createClass({

    isPositionAvailable() {
        return this.props.content === null;
    },

    isPositionNotInitialized() {
        return this.props.content === "";
    },

    setPossibleMark(e){
        let markNode = e.target.children[0];
        if(markNode){
            let markStyle = (this.props.mark === "o") ? "position-o" : "position-x";
            markNode.className = markStyle;
        }
    },

    notSelected(e){
        let markNode = e.target.children[0];
        if(markNode){
            markNode.className = "";
        }
    },

    render() {
        if(this.props.content === null){
            return (
                <div className="space-wrapper-1" onClick={this.props.selected} onMouseOver={this.setPossibleMark} onMouseOut={this.notSelected}>
                    <Mark markStyle={""} />
                </div>
            );
        }

        else if(this.props.content === "o" || this.props.content === "x"){
            let markStyle = "position-" + this.props.content;
            return (
                <div className="space-wrapper-1">
                    <Mark markStyle={markStyle} />
                </div>
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