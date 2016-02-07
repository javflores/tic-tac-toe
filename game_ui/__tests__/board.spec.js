'use strict';
jest.dontMock('../components/board/board.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Board = require('../components/board/board');
const Position = require('../components/board/position');

describe('Board', () => {
    it('renders nine empty positions', () => {
        let nextPlayer = "John the Champ";

        let renderedPlayer = TestUtils.renderIntoDocument(<Board />);

        var positions = TestUtils.scryRenderedComponentsWithType(renderedPlayer, Position);
        expect(positions.length).toEqual(9);
    });
});