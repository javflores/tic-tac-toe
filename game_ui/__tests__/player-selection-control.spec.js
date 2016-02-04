'use strict';
jest.dontMock('../components/player-selection-control.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const PlayerSelectionControl = require('../components/player-selection-control');

describe('When clicking on player control selection', () => {
    let control;
    beforeEach(() => {
        control = TestUtils.renderIntoDocument(
            <PlayerSelectionControl controlClicked={jest.genMockFunction()} />
        );
    });

    it('notifies selection', () => {
        let controlNode = TestUtils.findRenderedDOMComponentWithClass(control, 'btn-primary');

        TestUtils.Simulate.click(controlNode);

        expect(control.props.controlClicked).toBeCalled();
    });
});