'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let StatusStore = require('./game-requests/status-store'),
    Selection = require('./players-selection/selection'),
    GameProgress = require('./game-progress/game-progress');

const GameNotStarted = "not_started";

const GameControl = React.createClass({
    getControlBasedOnStatus(){
        if(this.state.status === GameNotStarted){
            return <Selection />;
        }

        return <GameProgress />;
    },

    getInitialState(){
        return {
            status: GameNotStarted
        };
    },

    mixins: [Reflux.connect(StatusStore, 'status')],

    render() {
        return (
            <div>
                {this.getControlBasedOnStatus()}
            </div>
        );
    }
});

module.exports = GameControl;