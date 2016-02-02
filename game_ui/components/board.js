'use strict';
import React from 'react';
import { render } from 'react-dom';

const Board = React.createClass({
    render() {
        return (
            <div className="row">
                <div className="row">
                    <div className="board-container col-lg-6 col-sm-6">
                        <table className="board">
                            <tbody>
                            <tr id="row1">
                                <td className="square"/>
                                <td className="square v"/>
                                <td className="square"/>
                            </tr>
                            <tr id="row2">
                                <td className="square h"/>
                                <td className="square middle"/>
                                <td className="square h"/>
                            </tr>
                            <tr id="row3">
                                <td className="square"/>
                                <td className="square v"/>
                                <td className="square"/>
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