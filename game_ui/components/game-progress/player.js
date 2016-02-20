'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let GameActions = require('../game-requests/game-actions');

const Player = React.createClass({
    isCurrentPlayer(){
        return this.props.player.name === this.props.nextPlayer
    },

    playerClicked(){
        if(this.props.player.type !== "computer"){
            return;
        }

        if(!this.isCurrentPlayer()){
            return;
        }

        GameActions.computerMove();
    },

    getTypeIcon(){
        return (this.props.player.type === "computer") ?
            "fa fa-laptop fa-5x" : "fa fa-user fa-5x";
    },

    getPlayerStyle(){
        let playerStyle = "col-lg-4 col-sm-4 control ";
        let playerStatusStyle = this.isCurrentPlayer() ? "control-focused" : "control-faded";
        return playerStyle.concat(playerStatusStyle)
    },

    render() {
        let typeIcon = this.getTypeIcon();
        let playerContainerStyle = this.getPlayerStyle();
        return (
            <div className={playerContainerStyle} onClick={this.playerClicked}>
                <a className={this.props.player.type}>
                    <i className={typeIcon}/>
                    <p>{this.props.player.name}</p>
                </a>
            </div>
        );
    }
});

module.exports = Player;