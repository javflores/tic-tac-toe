'use strict';
import React from 'react';
import { render } from 'react-dom';

let Heading = require('./heading'),
    Board = require('./board/board'),
    GameControl = require('./game-control');

const TicTacToe = React.createClass({
    render() {
        return (
            <div>
                <Heading />
                <Board />
                <GameControl />
            </div>
        );
    }
});

module.exports = TicTacToe;