'use strict';
jest.dontMock('../components/game-progress/game-progress.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const GameProgress = require('../components/game-progress/game-progress');
const Player = require('../components/game-progress/player');

describe('Game progress', () => {
    let gameProgress;
    beforeEach(() => {
        gameProgress = TestUtils.renderIntoDocument(<GameProgress />);
    });

    it('displays current players', () => {
        var players = TestUtils.scryRenderedComponentsWithType(gameProgress, Player);
        expect(players.length).toEqual(2);
    });
});