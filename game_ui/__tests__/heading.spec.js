'use strict';
jest.dontMock('../components/heading.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Heading = require('../components/heading');

describe('Tic Tac Toe heading component', () => {

    it('should contain main text', () => {
        var heading = TestUtils.renderIntoDocument(
            <Heading />
        );

        var mainText = TestUtils.findRenderedDOMComponentWithTag(heading, 'h1');
        expect(mainText.textContent).toEqual("Tic Tac Toe");
    });

    it('should contain secondary text', () => {
        var heading = TestUtils.renderIntoDocument(
            <Heading />
        );

        var secondaryText = TestUtils.findRenderedDOMComponentWithTag(heading, 'h4');
        expect(secondaryText.textContent).toEqual("Let's get some fun!");
    });
});