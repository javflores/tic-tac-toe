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

    parseMove(position){
        return {
            move: {
                row: position.row,
                column: position.column
            }
        };
    },

    listenables: GameActions,

    data: {},

    onStart(startGameParameters){
        let me = this;
        const url = 'http://localhost:4000/start';
        GameEngine.post(url)
            .send(this.parseGameStartParameters(startGameParameters))
            .type('application/json')
            .accept('application/json')
            .end((err, response) => {
                if(response && response.ok) {
                    me.data.gameId = response.body.game_id;
                    GameActions.start.completed({
                        game_id: response.body.game_id,
                        type: response.body.type,
                        players: startGameParameters.players,
                        nextPlayer: startGameParameters.firstPlayer,
                        board: response.body.board,
                        status: response.body.status
                    });
                }
            });
    },

    onMove(position){
        let me = this;
        const url = 'http://localhost:4000/move/' + me.data.gameId;
        GameEngine.post(url)
            .send(this.parseMove(position))
            .type('application/json')
            .accept('application/json')
            .end((err, response) => {
                if(response && response.ok) {
                    GameActions.move.completed({
                        game_id: response.body.game_id,
                        nextPlayer: response.body.next_player,
                        player: response.body.player,
                        board: response.body.board,
                        status: response.body.status
                    });
                }
            });
    },

    onComputerMove(){
        let me = this;
        const url = 'http://localhost:4000/move/' + me.data.gameId;
        GameEngine.post(url)
            .type('application/json')
            .accept('application/json')
            .end((err, response) => {
                if(response && response.ok) {
                    GameActions.move.completed({
                        game_id: response.body.game_id,
                        nextPlayer: response.body.next_player,
                        player: response.body.player,
                        board: response.body.board,
                        status: response.body.status
                    });
                }
            });
    }
});

module.exports = GameStore;