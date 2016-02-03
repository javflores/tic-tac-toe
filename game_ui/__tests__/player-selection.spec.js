'use strict';
jest.dontMock('../components/player-selection.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const PlayerSelection = require('../components/player-selection');

describe('Player selection', () => {
    let player, selection;
    beforeEach(() => {
        player = TestUtils.renderIntoDocument(<PlayerSelection player={{name: "", type:"Computer"}} nameChanged={jest.genMockFunction()} typeSelected={jest.genMockFunction()}/>);
    });

    it('notifies selection when name is introduced', () => {
        let playerNameInput = TestUtils.findRenderedDOMComponentWithTag(player, 'input');

        playerNameInput.value = 'Juan';
        TestUtils.Simulate.change(playerNameInput);

        expect(player.props.nameChanged).toBeCalledWith('Juan');
    });

    it('notifies selection when type is selected', () => {
        let computerTypeSelect = TestUtils.findRenderedDOMComponentWithClass(player, 'computer-type');

        TestUtils.Simulate.click(computerTypeSelect, {"target": {"textContent": "Computer"}});

        expect(player.props.typeSelected).toBeCalledWith('Computer');
    });
});