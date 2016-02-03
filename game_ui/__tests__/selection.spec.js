'use strict';
jest.dontMock('../components/selection.js');
jest.dontMock('../components/player-selection.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Selection = require('../components/selection');

describe('Selection when rendering Tic Tac Toe', () => {
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

        playerNameInput.value = 'Juan';
        TestUtils.Simulate.change(playerNameInput);

        expect(playerNameInput.value).toEqual("Juan");
    });

    it('displays human type of player by default', () => {
        let playerTypeSelect = TestUtils.findRenderedDOMComponentWithClass(selection, 'dropdown-toggle');

        expect(playerTypeSelect.textContent).toEqual("Human")
    });

    it('allows user to select type of player', () => {
        let computerTypeSelect = TestUtils.findRenderedDOMComponentWithClass(selection, 'computer-type');

        TestUtils.Simulate.click(computerTypeSelect, {"target": {"textContent": "Computer"}});

        let playerTypeSelect = TestUtils.findRenderedDOMComponentWithClass(selection, 'dropdown-toggle');
        expect(playerTypeSelect.textContent).toEqual("Computer")
    });

    it('display enabled continue selection arrow if player name is provided', () => {
        let playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');

        playerNameInput.value = 'Juan';
        TestUtils.Simulate.change(playerNameInput);

        let continueSelection = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        expect(continueSelection).toBeDefined();
    });

    it('should ask user to select second player', () => {
    });

    it('should ask user to select second player', () => {
    });

    it('should trigger initialization of the game if players were selected')
});

describe('Selection when players have been selected', () => {

    it('should ask user to provide first player', () => {

    });

    it('should trigger game start when first player is selected', () => {
    });
});