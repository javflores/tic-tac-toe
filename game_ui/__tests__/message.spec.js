'use strict';
jest.dontMock('../components/game-progress/message.js');

import React from 'react';
import ReactDOM from 'react-dom';
import TestUtils from 'react-addons-test-utils';

const Message = require('../components/game-progress/message');

describe('Displays provided message', () => {

    it('should contain main text', () => {
        let text = "This is awesome";
        let message = TestUtils.renderIntoDocument(<Message message={text}/>);

        var messageText = TestUtils.findRenderedDOMComponentWithTag(message, 'h4');
        expect(messageText.textContent).toEqual(text);
    });
});