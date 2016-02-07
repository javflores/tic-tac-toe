'use strict';
import React from 'react';
import { render } from 'react-dom';

const Player = React.createClass({
    render() {
        let typeIcon = (this.props.player.type === "computer") ? "fa fa-laptop fa-5x" : "fa fa-user fa-5x";
        return (
            <div className="col-lg-4 col-sm-4 control">
                <a className={this.props.player.type}>
                    <i className={typeIcon}/>
                    <p>{this.props.player.name}</p>
                </a>
            </div>
        );
    }
});

module.exports = Player;