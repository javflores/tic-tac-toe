'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let Position = require('./position');
let BoardStore = require("../game-requests/board-store");
let GameStartPlayersStore = require("../game-requests/game-start-players-store");

const Board = React.createClass({
    getBoardStyle(){
        return (this.state.board.length === 0) ? "board-inactive" : "board";
    },

    getPositions(){
        return (this.state.board.length === 0) ? new Array(9) : this.state.board;
    },

    onGameStart(startPlayers){
        let currentMark = (startPlayers.players[0].name === startPlayers.nextPlayer) ? "o" : "x";
        this.setState({
            currentPlayerMark: currentMark
        });
    },

    getInitialState(){
        return {
            board: []
        };
    },

    componentDidMount(){
        Reflux.listenTo(GameStartPlayersStore, this.onGameStart)
    },

    mixins: [Reflux.connect(BoardStore, 'board')],

    render() {
        let boardStyle = this.getBoardStyle();
        let positions = this.getPositions();
        return (
            <div className="row">
                <div className="row">
                    <div className="board-container col-lg-6 col-sm-6">
                        <table className={boardStyle}>
                            <tbody>
                            <tr id="row1">
                                <td className="square"><Position content={positions[0]} mark={this.state.currentPlayerMark}/></td>
                                <td className="square v"><Position content={positions[1]} mark={this.state.currentPlayerMark}/></td>
                                <td className="square"><Position content={positions[2]} mark={this.state.currentPlayerMark}/></td>
                            </tr>
                            <tr id="row2">
                                <td className="square h"><Position content={positions[3]} mark={this.state.currentPlayerMark}/></td>
                                <td className="square middle"><Position content={positions[4]} mark={this.state.currentPlayerMark}/></td>
                                <td className="square h"><Position content={positions[5]} mark={this.state.currentPlayerMark}/></td>
                            </tr>
                            <tr id="row3">
                                <td className="square"><Position content={positions[6]} mark={this.state.currentPlayerMark}/></td>
                                <td className="square v"><Position content={positions[7]} mark={this.state.currentPlayerMark}/></td>
                                <td className="square"><Position content={positions[8]} mark={this.state.currentPlayerMark}/></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        );
    }
});

module.exports = Board;