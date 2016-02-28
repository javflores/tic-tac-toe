'use strict';
jest.dontMock('../components/players-selection/selection.js');
jest.dontMock('../components/game-progress/message.js');
jest.dontMock('../components/players-selection/player-selection.js');
jest.dontMock('../components/players-selection/player-selection-control.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Selection = require('../components/players-selection/selection');

describe('When starting TicTacToe', () => {
    let selection,
        playerToStartSelected,
        typeSelected,
        gameStartClicked;

    beforeEach(() => {
        playerToStartSelected = jest.genMockFunction();
        typeSelected = jest.genMockFunction();
        gameStartClicked = jest.genMockFunction();
        let players = [{type: "human"}, {type: "computer"}];
        selection = TestUtils.renderIntoDocument(<Selection players={players}
                                                            playerToStart={"O"}
                                                            typeSelected={typeSelected}
                                                            playerToStartSelected={playerToStartSelected}
                                                            startGame={gameStartClicked}/>);
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

    it('allows user to select first player type', () => {
        let computerTypeSelect = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'computer-type')[0];

        TestUtils.Simulate.click(computerTypeSelect, {"target": {"textContent": "computer"}});

        expect(typeSelected).toBeCalledWith(0, "computer");
    });

    it('allows user to select second player type', () => {
        let humanTypeSelect = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'human-type')[1];

        TestUtils.Simulate.click(humanTypeSelect, {"target": {"textContent": "human"}});

        expect(typeSelected).toBeCalledWith(1, "human");
    });

    it('allows user to select player to start', () => {
        let notYetSelectedPlayer = TestUtils.scryRenderedDOMComponentsWithClass(selection, 'control')[2];

        TestUtils.Simulate.click(notYetSelectedPlayer);

        expect(playerToStartSelected).toBeCalled("X");
    });

    it('triggers game start when check icon is selected', () => {
        let startGame = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        TestUtils.Simulate.click(startGame);

        expect(gameStartClicked).toBeCalled();
    });

});

