'use strict';
jest.dontMock('../components/tictactoe.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const TicTacToe = require('../components/tictactoe');
const Heading = require('../components/heading');
const Board = require('../components/board/board');
const GameControl = require('../components/game-control');
const GameActions = require('../components/game-requests/game-actions');

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

describe('When game starts', () => {
    let tictactoe, nextPlayer, type, players;
    beforeEach(() => {
        GameActions.computerMove = jest.genMockFunction();

        tictactoe = TestUtils.renderIntoDocument(<TicTacToe />);

        type = "human_computer";
        players = [{
            name: "John",
            type: "human"
        }, {
            name: "C-3PO",
            type: "computer"
        }];
    });

    it('triggers a computer move if first player is computer', () => {
        nextPlayer = "C-3PO";

        tictactoe.onStartCompleted({type: type, players: players, nextPlayer: nextPlayer});

        expect(GameActions.computerMove).toBeCalled();
    });

    it('does not trigger a computer move if first player is human', () => {
        nextPlayer = "John";

        tictactoe.onStartCompleted({type: type, players: players, nextPlayer: nextPlayer});

        expect(GameActions.computerMove).not.toBeCalled();
    });
});

describe('When move is completed', () => {
    let tictactoe, type, players;
    beforeEach(() => {
        GameActions.computerMove = jest.genMockFunction();

        tictactoe = TestUtils.renderIntoDocument(<TicTacToe />);

        type = "human_computer";
        players = [{
            name: "John",
            type: "human"
        }, {
            name: "C-3PO",
            type: "computer"
        }];
    });

    it('triggers a computer move if next player is computer', () => {
        tictactoe.setState({type: type, players: players});

        tictactoe.onMoveCompleted({nextPlayer: "C-3PO"});

        expect(GameActions.computerMove).toBeCalled();
    });

    it('does not trigger a computer move if next player is human', () => {
        tictactoe.setState({type: type, players: players});

        tictactoe.onMoveCompleted({nextPlayer: "John"});

        expect(GameActions.computerMove).not.toBeCalled();
    });
});