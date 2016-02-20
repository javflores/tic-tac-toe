'use strict';
jest.dontMock('../components/players-selection/player-selection.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const PlayerSelection = require('../components/players-selection/player-selection');

describe('Player selection', () => {
    let player, selection;
    beforeEach(() => {
        player = TestUtils.renderIntoDocument(
            <PlayerSelection player={{type:"computer", typeIcon: "fa-laptop"}}
                             isPlayerToStart={false}
                             playerToStartSelected={jest.genMockFunction()}
                             typeSelected={jest.genMockFunction()}/>
        );
    });

    it('notifies selection when type is selected', () => {
        let humanTypeSelect = TestUtils.findRenderedDOMComponentWithClass(player, 'human-type');

        TestUtils.Simulate.click(humanTypeSelect, {"target": {"textContent": "human"}});

        expect(player.props.typeSelected).toBeCalledWith('human');
    });

    it('notifies selection when player to start is selected', () => {
        let renderedPlayer = TestUtils.scryRenderedDOMComponentsWithClass(player, 'col-lg-12 col-sm-12 control')[0];

        TestUtils.Simulate.click(renderedPlayer);

        expect(player.props.playerToStartSelected).toBeCalled();
    });
});