'use strict';
import React from 'react';
import { render } from 'react-dom';
let Heading = require('../components/heading'),
    Board = require('../components/board'),
    Selection = require('../components/selection');

const TicTacToe = React.createClass({
    render() {
        return (
            <div>
                <Heading />
                <Board />
                <Selection />
            </div>
        );
    }
});

module.exports = TicTacToe;