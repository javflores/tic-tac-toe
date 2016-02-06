'use strict';
import Reflux from 'reflux';
let GameActions = require('./game-actions');
let GameEngine = require('superagent');

const GameStore = Reflux.createStore({
    parseGameStartParameters(startGameParameters){
        let firstPlayer = startGameParameters.players[0];
        let secondPlayer = startGameParameters.players[1];
        return {
            o_name: firstPlayer.name,
            o_type: firstPlayer.type.toLowerCase(),
            x_name: secondPlayer.name,
            x_type: secondPlayer.type.toLowerCase(),
            first_player: startGameParameters.firstPlayer
        };
    },

    listenables: GameActions,

    onStart(startGameParameters){
        let me = this;
        const url = 'http://localhost:4000/start';
        GameEngine.post(url)
            .send(this.parseGameStartParameters(startGameParameters))
            .type('application/json')
            .accept('application/json')
            .end((err, response) => {
                if(response && response.ok) {
                    me.trigger(response.body);
                }
            });
    }
});

module.exports = GameStore;