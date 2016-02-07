'use strict';
jest.dontMock('../components/board/position.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Position = require('../components/board/position');

describe('Position when passed in empty content', () => {
    it('renders with empty space', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={""}/>);

        var renderedContents = TestUtils.scryRenderedDOMComponentsWithTag(renderedPosition, "i");
        expect(renderedContents.length).toEqual(0);
    });
});

describe('Position when passed in null content', () => {
    it('renders an available space', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={null}/>);

        var renderedContent = TestUtils.findRenderedDOMComponentWithTag(renderedPosition, "i");
        expect(renderedContent.className).toEqual('fa');
    });
});