'use strict';
jest.dontMock('../components/players-selection/selection.js');
jest.dontMock('../components/players-selection/player-selection.js');
jest.dontMock('../components/players-selection/player-selection-control.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Selection = require('../components/players-selection/selection');
const GameActions = require('../components/game-requests/game-actions');

describe('When starting TicTacToe', () => {
    let selection;
    beforeEach(() => {
        selection = TestUtils.renderIntoDocument(<Selection />);
    });

    it('should ask user to select first player', () => {
        let mainText = TestUtils.findRenderedDOMComponentWithTag(selection, 'h4');
        expect(mainText.textContent).toEqual("Select first player");
    });

    it('allows user to input name of first player', () => {
        let playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');

        let firstPlayerName = 'Juan';
        playerNameInput.value = firstPlayerName;
        TestUtils.Simulate.change(playerNameInput);

        expect(playerNameInput.value).toEqual(firstPlayerName);
    });

    it('displays Human-type of player by default', () => {
        let playerTypeSelect = TestUtils.findRenderedDOMComponentWithClass(selection, 'dropdown-toggle');

        expect(playerTypeSelect.textContent).toEqual("Human")
    });

    it('allows user to select type of player', () => {
        let computerTypeSelect = TestUtils.findRenderedDOMComponentWithClass(selection, 'computer-type');

        let firstPlayerType = "Computer";
        TestUtils.Simulate.click(computerTypeSelect, {"target": {"textContent": firstPlayerType}});

        let playerTypeSelect = TestUtils.findRenderedDOMComponentWithClass(selection, 'dropdown-toggle');
        expect(playerTypeSelect.textContent).toEqual(firstPlayerType)
    });

    it('display continue selection button if first player name is provided', () => {
        let playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');

        playerNameInput.value = 'Juan';
        TestUtils.Simulate.change(playerNameInput);

        let continueSelection = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        expect(continueSelection).toBeDefined();
    });
});

describe('When starting TicTacToe and first player has been selected', () => {
    let selection,
        playerNameInput;
    beforeEach(() => {
        selection = TestUtils.renderIntoDocument(<Selection />);
        playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');
        playerNameInput.value = "Juan";
        TestUtils.Simulate.change(playerNameInput);

        let continueSelection = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        TestUtils.Simulate.click(continueSelection);
    });

    it('should ask user to select second player', () => {
        let mainText = TestUtils.findRenderedDOMComponentWithTag(selection, 'h4');
        expect(mainText.textContent).toEqual("Select second player");
    });

    it('allows user to select player name', () => {
        playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');
        let playerInput = playerNameInput.value;

        expect(playerInput).toEqual("");
    });

    it('displays continue selection button if second player name is provided', () => {
        playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');
        playerNameInput.value = "John";

        TestUtils.Simulate.change(playerNameInput);

        let continueButton = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        expect(continueButton).toBeDefined();
    });
});

describe('When the two players have been provided', () => {
    let selection;
    beforeEach(() => {
        selection = TestUtils.renderIntoDocument(<Selection />);
        var playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');
        playerNameInput.value = "Juan";
        TestUtils.Simulate.change(playerNameInput);

        let continueSelection = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        TestUtils.Simulate.click(continueSelection);

        playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');
        playerNameInput.value = "John";
        TestUtils.Simulate.change(playerNameInput);

        continueSelection = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        TestUtils.Simulate.click(continueSelection);
    });

    it('asks user to select player that will start moving', () => {
        let mainText = TestUtils.findRenderedDOMComponentWithTag(selection, 'h4');
        expect(mainText.textContent).toEqual("Almost there! Select the player that will move first");
    });

    it('allows user to select player to start', () => {
        let firstPlayerOption = TestUtils.findRenderedDOMComponentWithClass(selection, 'first-player');

        let firstPlayer = "Juan";
        let selectedPlayer = {"textContent": firstPlayer, "childNodes": [{}, {className: "glyphicon glyphicon-user pull-right"}]};
        TestUtils.Simulate.click(firstPlayerOption, {"target": selectedPlayer});

        let playerToStartSelect = TestUtils.findRenderedDOMComponentWithClass(selection, 'dropdown-toggle');
        expect(playerToStartSelect.textContent).toEqual(firstPlayer);
    });

    it('sets type of player icon for selected player to start', () => {
        let firstPlayerOption = TestUtils.findRenderedDOMComponentWithClass(selection, 'first-player');

        let selectedPlayer = {"textContent": "Juan", "childNodes": [{}, {className: "glyphicon glyphicon-user pull-right"}]};
        TestUtils.Simulate.click(firstPlayerOption, {"target": selectedPlayer});

        let typeOfPlayerToStartIcon = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'glyphicon glyphicon-user pull-right')[2];
        expect(typeOfPlayerToStartIcon).toBeDefined();
    });

    it('should trigger game start if players were selected', () => {
        let firstPlayerOption = TestUtils.findRenderedDOMComponentWithClass(selection, 'first-player');
        let selectedPlayer = {"textContent": "Juan", "childNodes": [{}, {className: "glyphicon glyphicon-user pull-right"}]};
        TestUtils.Simulate.click(firstPlayerOption, {"target": selectedPlayer});

        let startGame = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        TestUtils.Simulate.click(startGame);

        let expectedGameStartParameters = {
            players: [{
                name: "Juan",
                type: "Human"
            },{
                name: "John",
                type: "Human"
            }],
            firstPlayer: "Juan"
        };
        expect(GameActions.start).toBeCalledWith(expectedGameStartParameters);
    });
});

