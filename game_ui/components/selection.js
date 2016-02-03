'use strict';
import React from 'react';
import { render } from 'react-dom';

let PlayerSelection = require('../components/player-selection');

const Selection = React.createClass({
    nameChanged(playerNumber, name){
        let players = this.state.players;
        let player = players[playerNumber-1];

        player.name = name;

        this.setState({
            players: players
        });
    },

    typeSelected(playerNumber, type){
        let players = this.state.players;
        let player = players[playerNumber-1];

        player.type = type;
        this.setState({
            players: players
        });
    },

    continueClicked(){
        this.setState({
            editingPlayerNumber: 2
        });
    },

    getInitialState(){
        return {
            editingPlayerNumber: 1,
            players: [{
                name: "",
                type: "Human"
            },{
                name: "",
                type: "Human"
            }]
        };
    },

    render() {
        if(this.state.editingPlayerNumber === 1){
            return (
                <div className="row">
                    <div className="row">
                        <div className="col-lg-12 title">
                            <h4 className="game-control subheader">Select first player</h4>
                        </div>
                    </div>
                    <div className="row">
                        <div className="form-group">
                            <PlayerSelection playerNumber={1} player={this.state.players[0]} nameChanged={this.nameChanged} typeSelected={this.typeSelected}/>
                            {(this.state.players[0].name !== "") ?
                                <div className="col-lg-2 continue-selection">
                                    <a className="btn btn-primary" onClick={this.continueClicked}>
                                        <i className="fa fa-arrow-right"/>
                                    </a>
                                </div> : <div></div>
                            }
                        </div>
                    </div>
                </div>
            );
        }

        return (
            <div className="row">
                <div className="row">
                    <div className="col-lg-12 title">
                        <h4 className="game-control subheader">Select second player</h4>
                    </div>
                </div>
                <div className="row">
                    <div className="form-group">
                        <PlayerSelection playerNumber={2} player={this.state.players[1]} nameChanged={this.nameChanged} typeSelected={this.typeSelected}/>
                        {(this.state.players[1].name !== "") ?
                            <div className="col-lg-2 continue-selection">
                                <a className="btn btn-primary" onClick={this.startGame}>
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