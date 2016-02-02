'use strict';
import React from 'react';
import { render } from 'react-dom';

const Selection = React.createClass({
    nameChanged(e){
        let playerName = e.target.value;
        let firstPlayer = this.state.firstPlayer;
        firstPlayer.name = playerName;

        this.setState({
            firstPlayerName: firstPlayer
        });
    },

    typeSelected(e){
        let type = e.target.text;
        let firstPlayer = this.state.firstPlayer;
        firstPlayer.type = type;
        this.setState({
            firstPlayerName: firstPlayer
        });
    },

    getInitialState(){
        return {
            firstPlayer: {
                name: "",
                type: "Human"
            }
        };
    },

    render() {
        return (
            <div className="row">
                <div className="row">
                    <div className="col-lg-12 title">
                        <h4 className="game-control subheader">Select first player</h4>
                    </div>
                </div>
                <div className="row">
                    <div className="form-group">
                        <div className="row">
                            <div className="input-player-name">
                                <input type="text" placeholder="Player name" className="form-control" value={this.state.firstPlayer.name}
                                       onChange={this.nameChanged}/>
                            </div>
                        </div>
                        <div className="row">
                            <ul className="nav navbar-nav">
                                <li className="dropdown">
                                    <a className="dropdown-toggle" data-toggle="dropdown">{this.state.firstPlayer.type}
                                        <span className={(this.state.firstPlayer.type == "Human") ? "glyphicon glyphicon-user pull-right" : "glyphicon glyphicon-blackboard pull-right"}/>
                                    </a>
                                    <ul className="dropdown-menu">
                                        <li><a className="human-type" onClick={this.typeSelected}>Human<span className="glyphicon glyphicon-user pull-right"/></a></li>
                                        <li className="divider"/>
                                        <li><a className="computer-type" onClick={this.typeSelected}>Computer<span className="glyphicon glyphicon-blackboard pull-right"/></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        {(this.state.firstPlayer.name !== "") ?
                            <div className="col-lg-2 continue-selection">
                                <a className="btn btn-primary" href="#">
                                    <i className="fa fa-arrow-right"/>
                                </a>
                            </div> : <div></div>
                        }
                    </div>
                </div>
            </div>
        );
    }
});

module.exports = Selection;