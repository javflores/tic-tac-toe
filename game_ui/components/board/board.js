'use strict';
import React from 'react';
import { render } from 'react-dom';

let Position = require('./position');

const Board = React.createClass({
    render() {
        return (
            <div className="row">
                <div className="row">
                    <div className="board-container col-lg-6 col-sm-6">
                        <table className="board">
                            <tbody>
                            <tr id="row1">
                                <td className="square"><Position /></td>
                                <td className="square v"><Position /></td>
                                <td className="square"><Position /></td>
                            </tr>
                            <tr id="row2">
                                <td className="square h"><Position /></td>
                                <td className="square middle"><Position /></td>
                                <td className="square h"><Position /></td>
                            </tr>
                            <tr id="row3">
                                <td className="square"><Position /></td>
                                <td className="square v"><Position /></td>
                                <td className="square"><Position /></td>
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