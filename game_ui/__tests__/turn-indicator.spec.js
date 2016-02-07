'use strict';
jest.dontMock('../components/game-progress/turn-indicator.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const TurnIndicator = require('../components/game-progress/turn-indicator');

describe('TurnIndicator', () => {
    it('displays the name of the next player', () => {
        let nextPlayer = "John the Champ";

        let renderedPlayer = TestUtils.renderIntoDocument(
            <TurnIndicator nextPlayer={nextPlayer}/>
        );

        var nameNode = TestUtils.findRenderedDOMComponentWithTag(renderedPlayer, "h3");
        expect(nameNode.textContent).toContain(nextPlayer);
    });
});