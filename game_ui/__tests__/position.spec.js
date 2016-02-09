'use strict';
jest.dontMock('../components/board/position.js');
jest.dontMock('../components/board/mark.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Position = require('../components/board/position');
const Mark = require('../components/board/mark');

describe('Position when passed in empty content', () => {
    it('does not render a mark', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={""}/>);

        var renderedContent = TestUtils.scryRenderedComponentsWithType(renderedPosition, Mark);
        expect(renderedContent.length).toEqual(0);
    });
});

describe('Position when available', () => {
    it('renders an available space', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={null}/>);

        var renderedContent = TestUtils.findRenderedComponentWithType(renderedPosition, Mark);
        expect(renderedContent).toBeDefined();
    });
});

describe('Position when taken', () => {
    it('renders corresponding mark', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={"o"}/>);

        var renderedContent = TestUtils.findRenderedComponentWithType(renderedPosition, Mark);
        expect(renderedContent).toBeDefined();
    });
});

