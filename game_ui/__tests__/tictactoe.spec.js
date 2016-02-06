'use strict';
jest.dontMock('../components/tictactoe.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const TicTacToe = require('../components/tictactoe');
const Heading = require('../components/heading');
const Board = require('../components/board');
const GameControl = require('../components/game-control');

describe('When rendering tic tac toe index', () => {
    let tictactoe;
    beforeEach(() => {
        tictactoe = TestUtils.renderIntoDocument(<TicTacToe />);
    });

    it('should render the game heading', () => {
        var heading = TestUtils.findRenderedComponentWithType(tictactoe, Heading);

        expect(heading).toBeDefined();
    });

    it('should render the board', () => {
        var board = TestUtils.findRenderedComponentWithType(tictactoe, Board);

        expect(board).toBeDefined();
    });

    it('should render game control', () => {
        var gameControl = TestUtils.findRenderedComponentWithType(tictactoe, GameControl);

        expect(gameControl).toBeDefined();
    });
});