'use strict';
jest.dontMock('../components/tictactoe.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const TicTacToe = require('../components/tictactoe');
const Heading = require('../components/heading');

describe('When rendering tic tac toe index', () => {

    it('should render the game heading', () => {
        var tictactoe = TestUtils.renderIntoDocument(
            <TicTacToe />
        );

        var heading = TestUtils.findRenderedComponentWithType(tictactoe, Heading);
        expect(heading).toBeDefined();
    });
});