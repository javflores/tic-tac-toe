'use strict';
import React from 'react';
import { render } from 'react-dom';

let Position = require('./position');

const Board = React.createClass({
    getBoardStyle(){
        return (this.props.board.length === 0) ? "board-inactive" : "board";
    },

    getPositions(){
        return (this.props.board.length === 0) ? new Array(9) : this.props.board;
    },

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
                                    <td className="square"><Position content={positions[0]} position={{row: 0, column: 0}} nextPlayer={this.props.nextPlayer}/></td>
                                    <td className="square v"><Position content={positions[1]} position={{row: 0, column: 1}} nextPlayer={this.props.nextPlayer}/></td>
                                    <td className="square"><Position content={positions[2]} position={{row: 0, column: 2}} nextPlayer={this.props.nextPlayer}/></td>
                                </tr>
                                <tr id="row2">
                                    <td className="square h"><Position content={positions[3]} position={{row: 1, column: 0}} nextPlayer={this.props.nextPlayer}/></td>
                                    <td className="square middle"><Position content={positions[4]} position={{row: 1, column: 1}} nextPlayer={this.props.nextPlayer}/></td>
                                    <td className="square h"><Position content={positions[5]} position={{row: 1, column: 2}} nextPlayer={this.props.nextPlayer}/></td>
                                </tr>
                                <tr id="row3">
                                    <td className="square"><Position content={positions[6]} position={{row: 2, column: 0}} nextPlayer={this.props.nextPlayer}/></td>
                                    <td className="square v"><Position content={positions[7]} position={{row: 2, column: 1}} nextPlayer={this.props.nextPlayer}/></td>
                                    <td className="square"><Position content={positions[8]} position={{row: 2, column: 2}} nextPlayer={this.props.nextPlayer}/></td>
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