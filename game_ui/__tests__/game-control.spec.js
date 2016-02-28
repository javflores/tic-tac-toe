'use strict';
jest.dontMock('../components/game-control.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

let Selection = require('../components/players-selection/selection'),
    GameControl = require('../components/game-control'),
    GameProgress = require('../components/game-progress/game-progress');

describe('When game', () => {
    describe('has not started', () => {
        it('renders selection of players', () => {
            let gameControl = TestUtils.renderIntoDocument(<GameControl status="not_started"/>);

            let selection = TestUtils.findRenderedComponentWithType(gameControl, Selection);

            expect(selection).toBeDefined();
        });
    });

    describe('has started', () => {
        it('renders game progress', () => {
            let gameControl = TestUtils.renderIntoDocument(<GameControl status="start"/>);

            let gameProgress = TestUtils.findRenderedComponentWithType(gameControl, GameProgress);

            expect(gameProgress).toBeDefined();
        });
    });
});