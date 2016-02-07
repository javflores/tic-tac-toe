'use strict';
import React from 'react';
import { render } from 'react-dom';

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
                <div className="space-wrapper-1" onMouseOver={this.setPossibleMark} onMouseOut={this.notSelected}>
                    <div className="space-wrapper-2">
                        <div className="space-wrapper-3">
                            <div className="space">
                                <div className="" >
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            );
        }

        return (
            <div>
            </div>
        );
    }
});

module.exports = Position;