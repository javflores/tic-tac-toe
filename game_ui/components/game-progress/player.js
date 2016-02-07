'use strict';
import React from 'react';
import { render } from 'react-dom';

const Player = React.createClass({
    getTypeIcon(){
        return (this.props.player.type === "computer") ?
            "fa fa-laptop fa-5x" : "fa fa-user fa-5x";
    },

    getPlayerStyle(){
        let playerStyle = "col-lg-4 col-sm-4 control ";
        let playerStatusStyle = (this.props.player.name === this.props.nextPlayer) ? "control-focused" : "control-faded";
        return playerStyle.concat(playerStatusStyle)
    },

    render() {
        let typeIcon = this.getTypeIcon();
        let playerContainerStyle = this.getPlayerStyle();
        return (
            <div className={playerContainerStyle}>
                <a className={this.props.player.type}>
                    <i className={typeIcon}/>
                    <p>{this.props.player.name}</p>
                </a>
            </div>
        );
    }
});

module.exports = Player;