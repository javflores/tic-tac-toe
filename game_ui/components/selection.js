'use strict';
import React from 'react';
import { render } from 'react-dom';

let PlayerSelection = require('../components/player-selection');

const Selection = React.createClass({
    nameChanged(name){
        let firstPlayer = this.state.firstPlayer;
        firstPlayer.name = name;

        this.setState({
            firstPlayerName: firstPlayer
        });
    },

    typeSelected(type){
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
                        <PlayerSelection player={this.state.firstPlayer} nameChanged={this.nameChanged} typeSelected={this.typeSelected}/>
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