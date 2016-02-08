'use strict';
import React from 'react';
import { render } from 'react-dom';

const Mark = React.createClass({
    render() {
        return (
            <div className="space-wrapper-2">
                <div className="space-wrapper-3">
                    <div className="space">
                        <div className={this.props.markStyle} >
                        </div>
                    </div>
                </div>
            </div>
        );
    }
});

module.exports = Mark;