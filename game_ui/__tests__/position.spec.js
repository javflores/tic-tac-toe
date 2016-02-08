'use strict';
jest.dontMock('../components/board/position.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Position = require('../components/board/position');
const GameActions = require('../components/game-requests/game-actions');

describe('Position when passed in empty content', () => {
    it('renders with empty space', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={""}/>);

        var renderedContent = TestUtils.scryRenderedDOMComponentsWithClass(renderedPosition, "space");
        expect(renderedContent.length).toEqual(0);
    });
});

describe('Position when available', () => {
    it('renders an available space', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={null}/>);

        var renderedContent = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "space");
        expect(renderedContent).toBeDefined();
    });

    it('displays O icon when mouse over if player is the first player', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={null} mark={"o"}/>);

        var positionNode = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "space-wrapper-1");
        TestUtils.Simulate.mouseOver(positionNode);

        var contentHovered = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "position-o");
        expect(contentHovered).toBeDefined();
    });

    it('displays X icon when mouse over if player is the second player', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={null} mark={"x"}/>);

        var positionNode = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "space-wrapper-1");
        TestUtils.Simulate.mouseOver(positionNode);

        var contentHovered = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "position-x");
        expect(contentHovered).toBeDefined();
    });

    it('displays empty space when mouse is out', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={null} mark={"x"}/>);
        var positionNode = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "space-wrapper-1");
        TestUtils.Simulate.mouseOver(positionNode);

        TestUtils.Simulate.mouseOut(positionNode);

        var contentHovered = TestUtils.scryRenderedDOMComponentsWithClass(renderedPosition, "position-x");
        expect(contentHovered.length).toEqual(0);
    });

    it('notifies board when clicked', () => {
        let renderedPosition = TestUtils.renderIntoDocument(<Position content={null} mark={"x"} selected={jest.genMockFunction()}/>);

        var positionNode = TestUtils.findRenderedDOMComponentWithClass(renderedPosition, "space-wrapper-1");
        TestUtils.Simulate.click(positionNode);

        expect(renderedPosition.props.selected).toBeCalled();
    });
});