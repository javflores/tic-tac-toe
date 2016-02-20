'use strict';
import React from 'react';
import { render } from 'react-dom';

const PlayerSelection = React.createClass({
    typeSelected(e){
        let type = e.target.textContent;
        this.props.typeSelected(type);
    },

    getPlayerStyle(){
        let playerStyle = "col-lg-12 col-sm-12 control ";
        let playerStatusStyle = this.props.isPlayerToStart ? "control-focused" : "";
        return playerStyle.concat(playerStatusStyle)
    },

    render() {
        let playerContainerStyle = this.getPlayerStyle();

        return (
            <div className="col-lg-4 col-sm-4">
                <div className={playerContainerStyle} onClick={this.props.playerToStartSelected}>
                    <a className={this.props.player.type}>
                        <i className={"fa ".concat(this.props.player.typeIcon, " fa-5x")}/>
                    </a>
                </div>
                <div className="row">
                    <ul className="nav navbar-nav">
                        <li className="dropdown">
                            <a className="dropdown-toggle" data-toggle="dropdown">{this.props.player.type}
                                <span className={"fa ".concat(this.props.player.typeIcon, " fa-2x pull-right")}/>
                            </a>
                            <ul className="dropdown-menu">
                                <li><a className="human-type" onClick={this.typeSelected}>human<span className="glyphicon glyphicon-user pull-right"/></a></li><li className="divider"/>
                                <li><a className="computer-type" onClick={this.typeSelected}>computer<span className="glyphicon glyphicon-blackboard pull-right"/></a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        );
    }
});

module.exports = PlayerSelection;