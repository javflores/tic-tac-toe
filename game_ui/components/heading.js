'use strict';
import React from 'react';
import { render } from 'react-dom';

const Heading = React.createClass({
    render() {
        return (
            <div className="row">
                <div className="col-lg-12 title">
                    <h1 className="subheader">Tic Tac Toe</h1>
                    <h4 className="subheader">Let's get some fun.</h4>
                </div>
            </div>
        );
    }
});

module.exports = Heading;