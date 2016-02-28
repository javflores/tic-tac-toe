'use strict';
import React from 'react';
import { render } from 'react-dom';

let GameActions = require('../game-requests/game-actions');

const Mark = React.createClass({
    isAvailable: function () {
        return this.props.content === null || this.props.content === "";
    },

    areControlsDisabled(){
        return !this.isAvailable() || this.props.gameType === "computer_computer";
    },

    nextPlayerMarkStyle: function () {
        return (this.props.nextPlayer === "O") ? "space position-o" : "space position-x";
    },

    positionSelected(){
        if(this.areControlsDisabled()){
            return;
        }

        GameActions.move(this.props.position);
    },

    setPossibleMark(e){
        if(this.areControlsDisabled()){
            return;
        }

        let available = e.target;
        if(available){
            available.className = this.nextPlayerMarkStyle();
        }
    },

    notSelected(e){
        if(this.areControlsDisabled()){
            return;
        }

        let available = e.target;
        if(available){
            available.className = "space";
        }
    },

    render() {
        let markStyle = this.isAvailable() ? "space" : "space position-" + this.props.content;

        return (
            <div className={markStyle}
                 onClick={this.positionSelected}
                 onMouseOver={this.setPossibleMark}
                 onMouseOut={this.notSelected}>
            </div>
        );
    }
});

module.exports = Mark;