'use strict';
import React from 'react';
import { render } from 'react-dom';
var Heading = require('../components/heading');

const TicTacToe = React.createClass({
    render() {
        return (
            <div>
                <Heading />
            </div>
        );
    }
});

module.exports = TicTacToe;