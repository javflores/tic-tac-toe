'use strict';
import React from 'react';
import { render } from 'react-dom';

const PlayerSelectionControl = React.createClass({
    render() {
        return (
            <div className="row">
                <a className="btn btn-primary" onClick={this.props.controlClicked}>
                    <i className="fa fa-check "/>
                </a>
            </div>
        );
    }
});

module.exports = PlayerSelectionControl;