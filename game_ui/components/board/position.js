'use strict';
import React from 'react';
import { render } from 'react-dom';

const Position = React.createClass({

    isPositionAvailable() {
        return this.props.content === null;
    },

    isPositionNotInitialized() {
        return this.props.content === "";
    },

    getContent(){
        if(this.isPositionAvailable()){
            return <i className="fa"/>;
        }
        if(this.isPositionNotInitialized()){
            return <div></div>;
        }
    },

    render() {
        return (
            <div>
                {this.getContent()}
            </div>
        );
    }
});

module.exports = Position;