'use strict';
jest.dontMock('../components/game-progress/game-progress.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const GameProgress = require('../components/game-progress/game-progress');
const Player = require('../components/game-progress/player');
const Message = require('../components/game-progress/message');
const TurnIndicator = require('../components/game-progress/turn-indicator');

describe('Game progress', () => {
    let gameProgress;
    beforeEach(() => {
        gameProgress = TestUtils.renderIntoDocument(<GameProgress />);
    });

    it('displays current players', () => {
        var players = TestUtils.scryRenderedComponentsWithType(gameProgress, Player);
        expect(players.length).toEqual(2);
    });

    it('displays game progress message', () => {
        var message = TestUtils.findRenderedComponentWithType(gameProgress, Message);
        expect(message).toBeDefined();
    });

    it('displays turn indicator', () => {
        var turnIndicator = TestUtils.findRenderedComponentWithType(gameProgress, TurnIndicator);
        expect(turnIndicator).toBeDefined();
    });
});