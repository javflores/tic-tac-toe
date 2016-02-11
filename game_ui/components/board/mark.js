'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let CurrentMarkStore = require("../game-requests/current-mark-store");
let GameActions = require('../game-requests/game-actions');

const Mark = React.createClass({
    isAvailable: function () {
        return this.props.content === null || this.props.content === "";
    },

    nextPlayerMarkStyle: function () {
        return (this.state.currentMark === "o") ? "space position-o" : "space position-x";
    },

    positionSelected(){
        if(!this.isAvailable()){
            return;
        }

        GameActions.move(this.props.position);
    },

    setPossibleMark(e){
        if(!this.isAvailable()){
            return;
        }

        let available = e.target;
        if(available){
            available.className = this.nextPlayerMarkStyle();
        }
    },

    notSelected(e){
        if(!this.isAvailable()){
            return;
        }

        let available = e.target;
        if(available){
            available.className = "space";
        }
    },

    mixins: [Reflux.connect(CurrentMarkStore, 'currentMark')],

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