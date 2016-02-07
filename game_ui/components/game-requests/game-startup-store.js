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
            o_type: firstPlayer.type,
            x_name: secondPlayer.name,
            x_type: secondPlayer.type,
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
                    me.trigger({
                        game_id: response.body.game_id,
                        type: response.body.type,
                        players: startGameParameters.players,
                        nextPlayer: startGameParameters.firstPlayer,
                        board: response.body.board,
                        status: response.body.status
                    });
                }
            });
    }
});

module.exports = GameStore;