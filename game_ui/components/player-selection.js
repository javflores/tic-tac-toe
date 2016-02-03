'use strict';
import React from 'react';
import { render } from 'react-dom';

const PlayerSelection = React.createClass({
    nameChanged(e){
        let playerName = e.target.value;
        this.props.nameChanged(this.props.playerNumber, playerName);
    },

    typeSelected(e){
        let type = e.target.textContent;
        this.props.typeSelected(this.props.playerNumber, type);
    },

    render() {
        return (
            <div className="row">
                <div className="row">
                    <div className="input-player-name">
                        <input type="text" placeholder="Player name" className="form-control" value={this.props.player.name}
                               onChange={this.nameChanged}/>
                    </div>
                </div>
                <div className="row">
                    <ul className="nav navbar-nav">
                        <li className="dropdown">
                            <a className="dropdown-toggle" data-toggle="dropdown">{this.props.player.type}
                                <span className={(this.props.player.type == "Human") ? "glyphicon glyphicon-user pull-right" : "glyphicon glyphicon-blackboard pull-right"}/>
                            </a>
                            <ul className="dropdown-menu">
                                <li><a className="human-type" onClick={this.typeSelected}>Human<span className="glyphicon glyphicon-user pull-right"/></a></li>
                                <li className="divider"/>
                                <li><a className="computer-type" onClick={this.typeSelected}>Computer<span className="glyphicon glyphicon-blackboard pull-right"/></a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        );
    }
});

module.exports = PlayerSelection;