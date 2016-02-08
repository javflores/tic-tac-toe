'use strict';
jest.dontMock('../components/game-requests/game-startup-store.js');

var EngineRequest = require('superagent');
const GameStartupStore = require('../components/game-requests/game-startup-store');
const GameActions = require('../components/game-requests/game-actions');


describe('Game store', () => {
    let gameStartParameters;
    beforeEach(() => {
        gameStartParameters = {
            players: [{
                name: "R2-D2",
                type: "computer"
            },{
                name: "C-3PO",
                type: "computer"
            }],
            firstPlayer: "R2-D2"
        };
    });

    it('calls game engine to start game when notified about game start', () => {
        GameStartupStore.onStart(gameStartParameters);

        expect(EngineRequest.post).toBeCalledWith("http://localhost:4000/start");
    });

    it('passes game start parameters to game engine when notified about game start', () => {
        GameStartupStore.onStart(gameStartParameters);

        let parsedGameParameters = {
            o_name: "R2-D2",
            o_type: "computer",
            x_name: "C-3PO",
            x_type: "computer",
            first_player: "R2-D2"
        };
        expect(EngineRequest.send).toBeCalledWith(parsedGameParameters);
    });

    it('triggers game start completed with game engine start response when notified about game start', () => {
        GameStartupStore.onStart(gameStartParameters);

        let expectedGameEngineStart = {
            game_id: "123456",
            status: "start",
            players:[{
                name: "R2-D2",
                type: "computer"
            },{
                name: "C-3PO",
                type: "computer"
            }],
            type: "computer_computer",
            board: [null, null, null, null, null, null, null, null, null],
            nextPlayer: "R2-D2"
        };
        expect(GameActions.start.completed).toBeCalledWith(expectedGameEngineStart);
    });
});