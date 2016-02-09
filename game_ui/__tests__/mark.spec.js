'use strict';
jest.dontMock('../components/board/mark.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Mark = require('../components/board/mark');
const GameActions = require('../components/game-requests/game-actions');

describe('Mark when passed in o mark', () => {
    it('renders the mark', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Mark content={"o"}/>);

        var renderedMark = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "position-o");
        expect(renderedMark).toBeDefined();
    });
});

describe('Mark when passed in x mark', () => {
    it('renders the mark', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Mark content={"x"}/>);

        var renderedMark = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "position-x");
        expect(renderedMark).toBeDefined();
    });
});

describe('Position when available', () => {
    it('displays mark icon of next player when mouse over', () => {
        let renderedMark = TestUtils.renderIntoDocument(<Mark content={null}/>);

        renderedMark.nextPlayerMarkStyle = jest.genMockFunction().mockReturnValueOnce("position-o");

        var positionNode = TestUtils.findRenderedDOMComponentWithClass(renderedMark, "space-wrapper-1");
        TestUtils.Simulate.mouseOver(positionNode);

        var contentHovered = TestUtils.findRenderedDOMComponentWithClass(renderedMark, "position-o");
        expect(contentHovered).toBeDefined();
    });

    it('displays empty space when mouse is out', () => {
        let renderedMark = TestUtils.renderIntoDocument(<Mark content={null}/>);
        var positionNode = TestUtils.findRenderedDOMComponentWithClass(renderedMark, "space-wrapper-1");
        TestUtils.Simulate.mouseOver(positionNode);

        TestUtils.Simulate.mouseOut(positionNode);

        var contentHovered = TestUtils.scryRenderedDOMComponentsWithClass(renderedMark, "position-x");
        expect(contentHovered.length).toEqual(0);
    });

    it('triggers a board when clicked', () => {
        GameActions.move = jest.genMockFunction();
        let position = {row: 0, column: 0};
        let renderedMark = TestUtils.renderIntoDocument(<Mark content={null} position={position}/>);

        var positionNode = TestUtils.findRenderedDOMComponentWithClass(renderedMark, "space-wrapper-1");
        TestUtils.Simulate.click(positionNode);

        expect(GameActions.move).toBeCalledWith(position);
    });
});