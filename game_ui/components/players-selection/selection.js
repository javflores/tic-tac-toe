'use strict';
import React from 'react';
import { render } from 'react-dom';

let PlayerSelection = require('./player-selection');
let PlayerSelectionControl = require('./player-selection-control');
let GameActions = require('../game-requests/game-actions');

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
        let typeIcon = (type === "human") ? "glyphicon-user" : "glyphicon-blackboard";
        let players = this.state.players;
        let player = players[playerNumber-1];

        player.type = type;
        player.typeIcon = "glyphicon ".concat(typeIcon, " pull-right");
        this.setState({
            players: players
        });
    },

    continueClicked(){
        this.setState({
            editingPlayerNumber: 2
        });
    },

    continueFirstPlayerSelection(){
        this.setState({
            playersSelected: true
        });
    },

    playerToStartSelected(e){
        let playerToStartName = e.target.textContent;
        let playerToStartIcon = e.target.childNodes[1].className;
        let playerToStart = this.state.playerToStart;
        playerToStart.name = playerToStartName;
        playerToStart.typeIcon = playerToStartIcon;

        this.setState({
            playerToStart: playerToStart
        });
    },

    startGame(){
        let players = this.state.players.map((player) => {
            return {
                name: player.name,
                type: player.type
            };
        });
        GameActions.start({
            players: players,
            firstPlayer: this.state.playerToStart.name
        });
    },

    getInitialState(){
        return {
            playersSelected: false,
            editingPlayerNumber: 1,
            players: [{
                name: "",
                type: "human",
                typeIcon: "glyphicon glyphicon-user pull-right"
            },{
                name: "",
                type: "human",
                typeIcon: "glyphicon glyphicon-user pull-right"
            }],
            playerToStart: {
                name: "",
                typeIcon: ""
            }
        };
    },

    render() {
        if(this.state.playersSelected === true){
            return (
                <div className="row">
                    <div className="row">
                        <div className="col-lg-12 title">
                            <h4 className="game-control subheader">Almost there! Select the player that will move first</h4>
                        </div>
                    </div>
                    <div className="row">
                        <div className="form-group">
                            <div className="row">
                                <ul className="first-player-select nav navbar-nav">
                                    <li className="dropdown">
                                        <a className="dropdown-toggle" data-toggle="dropdown">{this.state.playerToStart.name}
                                            <span className={this.state.playerToStart.typeIcon}/>
                                        </a>
                                        <ul className="dropdown-menu">
                                            <li onClick={this.playerToStartSelected}><a className="first-player">{this.state.players[0].name}<span className={this.state.players[0].typeIcon}/></a></li>
                                            <li className="divider"/>
                                            <li onClick={this.playerToStartSelected}><a className="second-player">{this.state.players[1].name}<span className={this.state.players[1].typeIcon}/></a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            {(this.state.playerToStart.name !== "") ? <PlayerSelectionControl controlClicked={this.startGame} /> : <div></div>}
                        </div>
                    </div>
                </div>
            );
        }

        else if(this.state.editingPlayerNumber === 1){
            return (
                <div className="row">
                    <div className="row">
                        <div className="col-lg-12 title">
                            <h4 className="game-control subheader">Select first player</h4>
                        </div>
                    </div>
                    <div className="row">
                        <div className="form-group">
                            <PlayerSelection key={1} playerNumber={1} player={this.state.players[0]} nameChanged={this.nameChanged} typeSelected={this.typeSelected}/>
                            {(this.state.players[0].name !== "") ? <PlayerSelectionControl controlClicked={this.continueClicked} /> : <div></div>}
                        </div>
                    </div>
                </div>
            );
        }

        else {
            return (
                <div className="row">
                    <div className="row">
                        <div className="col-lg-12 title">
                            <h4 className="game-control subheader">Select second player</h4>
                        </div>
                    </div>
                    <div className="row">
                        <div className="form-group">
                            <PlayerSelection key={2} playerNumber={2} player={this.state.players[1]} nameChanged={this.nameChanged} typeSelected={this.typeSelected}/>
                            {(this.state.players[1].name !== "") ? <PlayerSelectionControl controlClicked={this.continueFirstPlayerSelection} /> : <div></div>}
                        </div>
                    </div>
                </div>
            );
        }
    }
});

module.exports = Selection;