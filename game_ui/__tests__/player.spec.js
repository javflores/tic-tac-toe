'use strict';
jest.dontMock('../components/game-progress/player.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const GameActions = require('../components/game-requests/game-actions');
const Player = require('../components/game-progress/player');

describe('Player', () => {

    it('renders with computer type icon when computer is provided', () => {
        let computerizedPlayer = {type: "computer"};

        let computerPlayerNode = TestUtils.renderIntoDocument(
            <Player player={computerizedPlayer}/>
        );

        let computerIcon = 'fa fa-laptop fa-5x';
        var typeIconNode = TestUtils.findRenderedDOMComponentWithTag(computerPlayerNode, "i");
        expect(typeIconNode.className).toEqual(computerIcon);
    });

    it('renders with human type icon when human is provided', () => {
        let humanizedPlayer = {type: "human"};

        let humanPlayerNode = TestUtils.renderIntoDocument(
            <Player player={humanizedPlayer}/>
        );

        let humanIcon = 'fa fa-user fa-5x';
        var typeIconNode = TestUtils.findRenderedDOMComponentWithTag(humanPlayerNode, "i");
        expect(typeIconNode.className).toEqual(humanIcon);
    });

    it('is faded when it is not the next player', () => {
        let renderedPlayer = TestUtils.renderIntoDocument(
            <Player mark={"O"} player={{type: "computer"}} nextPlayer={"X"}/>
        );

        var playerNode = TestUtils.findRenderedDOMComponentWithTag(renderedPlayer, "div");
        expect(playerNode.className).toContain("control-faded");
    });

    it('is highlighted when it is the next player', () => {
        let renderedPlayer = TestUtils.renderIntoDocument(
            <Player mark={"O"} player={{type: "computer"}} nextPlayer={"O"}/>
        );

        var playerNode = TestUtils.findRenderedDOMComponentWithTag(renderedPlayer, "div");
        expect(playerNode.className).toContain("control-focused");
    });

    it('does not trigger move when clicked and it is not a computer', () => {
        GameActions.computerMove = jest.genMockFunction();
        let humanPlayer = {type: "human"};
        let humanPlayerNode = TestUtils.renderIntoDocument(<Player player={humanPlayer}/>);

        var playerNode = TestUtils.findRenderedDOMComponentWithTag(humanPlayerNode, "div");
        TestUtils.Simulate.click(playerNode);

        expect(GameActions.computerMove).not.toBeCalled();
    });

    it('does not trigger move when it is not the current player', () => {
        GameActions.computerMove = jest.genMockFunction();
        let computerPlayer = {type: "computer"};
        let computerPlayerNode = TestUtils.renderIntoDocument(<Player mark={"O"} player={computerPlayer} nextPlayer="X"/>);

        var playerNode = TestUtils.findRenderedDOMComponentWithTag(computerPlayerNode, "div");
        TestUtils.Simulate.click(playerNode);

        expect(GameActions.computerMove).not.toBeCalled();
    });

    it('triggers computer move when computer and current player', () => {
        GameActions.computerMove = jest.genMockFunction();
        let computerPlayer = {type: "computer"};
        let computerPlayerNode = TestUtils.renderIntoDocument(<Player mark={"O"} player={computerPlayer} nextPlayer="O"/>);

        var playerNode = TestUtils.findRenderedDOMComponentWithTag(computerPlayerNode, "div");
        TestUtils.Simulate.click(playerNode);

        expect(GameActions.computerMove).toBeCalled();
    });
});