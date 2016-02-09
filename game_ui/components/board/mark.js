'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let CurrentMarkStore = require("../game-requests/current-mark-store");
let GameActions = require('../game-requests/game-actions');

const Mark = React.createClass({
    positionSelected(){
        if(this.state.currentMark && this.state.currentMark !== "" )
            return;

        GameActions.move(this.props.position);
    },

    setPossibleMark(e){
        if(this.state.currentMark !== "" )
            return;

        let markNode = e.target.children[0];
        if(markNode){
            let markStyle = (this.state.currentMark === "o") ? "position-o" : "position-x";
            markNode.className = markStyle;
        }
    },

    notSelected(e){
        if(this.state.currentMark !== "" )
            return;

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

    componentWillReceiveProps(nextProps){
        if(nextProps.content !== ""){
            this.setState({
                currentMark: nextProps.content
            });
        }
    },

    //componentWillUpdate(nextProps){
    //    if(nextProps.available){
    //        MarkClickGuard.deactivate();
    //        MarkHoverGuard.deactivate();
    //    }
    //    else{
    //        MarkClickGuard.activate();
    //        MarkHoverGuard.activate();
    //    }
    //},

    //componentWillMount(){
    //    if(this.props.available){
    //        MarkClickGuard.deactivate();
    //        MarkHoverGuard.deactivate();
    //    }
    //    else{
    //        MarkClickGuard.activate();
    //        MarkHoverGuard.activate();
    //    }
    //},

    //mixins: [Reflux.connect(CurrentMarkStore, 'currentMark')],

    //mixins: [Reflux.listenTo(GameActions.move)],
    //
    render() {
        let markStyle = (this.state.currentMark === "") ? "" : "position-" + this.state.currentMark;

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