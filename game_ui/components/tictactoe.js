'use strict';
import React from 'react';
import { render } from 'react-dom';
require('./game-requests/game-store');

let Heading = require('./heading'),
    Board = require('./board/board'),
    GameControl = require('./game-control'),
    GameOver = require('./game-progress/game-over');

const TicTacToe = React.createClass({
    render() {
        return (
            <div>
                <GameOver />
                <Heading />
                <Board />
                <GameControl />
            </div>
        );
    }
});

module.exports = TicTacToe;