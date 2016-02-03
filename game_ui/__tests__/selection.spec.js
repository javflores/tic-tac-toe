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

    it('display continue selection button if first player name is provided', () => {
        let playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');

        playerNameInput.value = 'Juan';
        TestUtils.Simulate.change(playerNameInput);

        let continueSelection = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        expect(continueSelection).toBeDefined();
    });

    it('displays second player selection when user clicks continue', () => {
        let playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');
        playerNameInput.value = "Juan";
        TestUtils.Simulate.change(playerNameInput);

        let continueSelection = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        TestUtils.Simulate.click(continueSelection);

        expect(playerNameInput.value).toEqual("");
    });

    it('display start game button if second player name is provided', () => {
        let playerNameInput = TestUtils.findRenderedDOMComponentWithTag(selection, 'input');
        playerNameInput.value = "Juan";
        TestUtils.Simulate.change(playerNameInput);
        let continueSelection = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        TestUtils.Simulate.click(continueSelection);

        playerNameInput.value = "John";
        TestUtils.Simulate.change(playerNameInput);

        let continueStartup = TestUtils.findRenderedDOMComponentWithClass(selection, 'btn-primary');
        expect(continueStartup).toBeDefined();
    });

    it('should trigger initialization of the game if players were selected', () => {
    });
});

