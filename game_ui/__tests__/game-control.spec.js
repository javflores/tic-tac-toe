'use strict';
jest.dontMock('../components/game-control.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Selection = require('../components/players-selection/selection');
const GameControl = require('../components/game-control');

describe('When game', () => {
    let gameControl;
    beforeEach(() => {
        gameControl = TestUtils.renderIntoDocument(<GameControl />);
    });

    describe('has not started', () => {
        it('renders selection of players', () => {
            var selection = TestUtils.findRenderedComponentWithType(gameControl, Selection);

            expect(selection).toBeDefined();
        });
    });
});