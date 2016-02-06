'use strict';
import React from 'react';
import { render } from 'react-dom';

let Heading = require('../components/heading'),
    Board = require('../components/board'),
    GameControl = require('../components/game-control');

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