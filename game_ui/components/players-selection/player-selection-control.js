'use strict';
import React from 'react';
import { render } from 'react-dom';

const PlayerSelectionControl = React.createClass({
    render() {
        return (
            <div className="row">
                <div className="col-lg-2 continue-selection">
                    <a className="btn btn-primary" onClick={this.props.controlClicked}>
                        <i className="fa fa-arrow-right"/>
                    </a>
                </div>
            </div>
        );
    }
});

module.exports = PlayerSelectionControl;