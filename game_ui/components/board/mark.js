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

        let markNode = e.target.children[0];
        if(markNode){
            let markStyle = (this.state.currentMark === "o") ? "position-o" : "position-x";
            markNode.className = markStyle;
        }
    },

    notSelected(e){
        if(!this.isAvailable()){
            return;
        }

        let markNode = e.target.children[0];
        if(markNode){
            markNode.className = "";
        }
    },

    getInitialState(){
        return {
            currentMark: ''
        };
    },

    mixins: [Reflux.connect(CurrentMarkStore, 'currentMark')],

    render() {
        let markStyle = (this.props.content === "") ? "" : "position-" + this.props.content;

        return (
            <div className="space-wrapper-1"
                 onClick={this.positionSelected}
                 onMouseOver={this.setPossibleMark}
                 onMouseOut={this.notSelected}>

                <div className="space-wrapper-2">
                    <div className="space-wrapper-3">
                        <div className="space">
                            <div className={markStyle} >
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        );
    }
});

module.exports = Mark;