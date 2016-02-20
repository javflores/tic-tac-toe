'use strict';
jest.dontMock('../components/players-selection/selection.js');
jest.dontMock('../components/game-progress/message.js');
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

    it('renders selection message', () => {
        let mainText = TestUtils.findRenderedDOMComponentWithTag(selection, 'h4');
        expect(mainText.textContent).toEqual("Select type of players and player that goes first");
    });

    it('displays Human versus computer players by default', () => {
        let players = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'fa fa-5x');

        expect(players[0].className).toEqual("fa fa-user fa-5x");
        expect(players[1].className).toEqual("fa fa-laptop fa-5x");
    });

    it('allows user to select computer type for player', () => {
        let computerTypeSelect = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'computer-type')[0];

        TestUtils.Simulate.click(computerTypeSelect, {"target": {"textContent": "computer"}});

        let playerTypeSelect = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'dropdown-toggle')[0];
        expect(playerTypeSelect.textContent).toEqual("computer");
    });

    it('allows user to select human type for player', () => {
        let humanTypeSelect = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'human-type')[1];

        TestUtils.Simulate.click(humanTypeSelect, {"target": {"textContent": "human"}});

        let playerTypeSelect = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'dropdown-toggle')[1];
        expect(playerTypeSelect.textContent).toEqual("human");
    });

    it('sets computer type of player icon when selecting computer type', () => {
        let humanTypeSelect = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'computer-type')[0];

        TestUtils.Simulate.click(humanTypeSelect, {"target": {"textContent": "computer"}});

        let firstPlayer = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'fa fa-5x')[0];
        expect(firstPlayer.className).toEqual("fa fa-laptop fa-5x");
    });

    it('allows user to select player to start', () => {
        let notYetSelectedPlayer = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'control')[2];

        TestUtils.Simulate.click(notYetSelectedPlayer);

        let playerToStart = selection.state.playerToStart;
        expect(playerToStart).toEqual("X");
    });

    it('triggers game start when check icon is selected', () => {
        let startGame = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        TestUtils.Simulate.click(startGame);

        let expectedGameStartParameters = {
            players: [{
                type: "human"
            },{
                type: "computer"
            }],
            firstPlayer: "O"
        };
        expect(GameActions.start).toBeCalledWith(expectedGameStartParameters);
    });

});

