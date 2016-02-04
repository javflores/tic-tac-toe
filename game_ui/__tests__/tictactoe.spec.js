'use strict';
jest.dontMock('../components/tictactoe.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const TicTacToe = require('../components/tictactoe');
const Heading = require('../components/heading');
const Board = require('../components/board');
const Selection = require('../components/players-selection/selection');

describe('When rendering tic tac toe index', () => {

    it('should render the game heading', () => {
        var tictactoe = TestUtils.renderIntoDocument(
            <TicTacToe />
        );

        var heading = TestUtils.findRenderedComponentWithType(tictactoe, Heading);
        expect(heading).toBeDefined();
    });

    it('should render the board', () => {
        var tictactoe = TestUtils.renderIntoDocument(
            <TicTacToe />
        );

        var board = TestUtils.findRenderedComponentWithType(tictactoe, Board);
        expect(board).toBeDefined();
    });

    it('should render game selection', () => {
        var tictactoe = TestUtils.renderIntoDocument(
            <TicTacToe />
        );

        var gameSelection = TestUtils.findRenderedComponentWithType(tictactoe, Selection);
        expect(gameSelection).toBeDefined();
    });
});