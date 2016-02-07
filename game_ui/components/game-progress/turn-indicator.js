'use strict';
import React from 'react';
import { render } from 'react-dom';

const TurnIndicator = React.createClass({
    render() {
        return (
            <div className="col-lg-4 col-sm-4 control">
                <h3 className="subheader prompt">Turn for {this.props.nextPlayer}!</h3>
            </div>
        );
    }
});

module.exports = TurnIndicator;