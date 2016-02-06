'use strict';
import React from 'react';
import { render } from 'react-dom';
import Reflux from 'reflux';

let GameStatusStore = require('./game-requests/game-status-store'),
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

    mixins: [Reflux.connect(GameStatusStore, 'status')],

    render() {
        return (
            <div>
                {this.getControlBasedOnStatus()}
            </div>
        );
    }
});

module.exports = GameControl;