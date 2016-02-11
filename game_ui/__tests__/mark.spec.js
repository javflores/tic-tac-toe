'use strict';
jest.dontMock('../components/board/mark.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Mark = require('../components/board/mark');
const GameActions = require('../components/game-requests/game-actions');

describe('When is taken with O', () => {
    it('renders the mark', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Mark content={"o"}/>);

        var renderedMark = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "position-o");
        expect(renderedMark).toBeDefined();
    });
});

describe('When is taken with X', () => {
    it('renders the mark', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Mark content={"x"}/>);

        var renderedMark = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "position-x");
        expect(renderedMark).toBeDefined();
    });
});

describe('Position when available', () => {
    let renderedMark,
        position;
    beforeEach(() => {
        position = {row: 0, column: 0};
        renderedMark = TestUtils.renderIntoDocument(<Mark content={null} position={position}/>);
        renderedMark.nextPlayerMarkStyle = jest.genMockFunction().mockReturnValueOnce("position-o");
    });

    it('displays mark icon of next player when mouse over', () => {
        let available = TestUtils.findRenderedDOMComponentWithClass(renderedMark, "space");
        TestUtils.Simulate.mouseOver(available);

        let contentHovered = TestUtils.findRenderedDOMComponentWithClass(renderedMark, "position-o");
        expect(contentHovered).toBeDefined();
    });

    it('displays empty space when mouse is out', () => {
        let available = TestUtils.findRenderedDOMComponentWithClass(renderedMark, "space");
        TestUtils.Simulate.mouseOver(available);

        TestUtils.Simulate.mouseOut(available);

        let contentHovered = TestUtils.scryRenderedDOMComponentsWithClass(renderedMark, "position-x");
        expect(contentHovered.length).toEqual(0);
    });

    it('triggers a board when clicked', () => {
        GameActions.move = jest.genMockFunction();

        let available = TestUtils.findRenderedDOMComponentWithClass(renderedMark, "space");
        TestUtils.Simulate.click(available);

        expect(GameActions.move).toBeCalledWith(position);
    });
});