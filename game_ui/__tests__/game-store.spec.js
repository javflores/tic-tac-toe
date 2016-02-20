'use strict';
jest.dontMock('../components/game-requests/game-store.js');

var EngineRequest = require('superagent');
const GameStartupStore = require('../components/game-requests/game-store');
const GameActions = require('../components/game-requests/game-actions');


describe('Game store', () => {
    let gameStartParameters;
    beforeEach(() => {
        gameStartParameters = {
            players: [{
                type: "computer"
            },{
                type: "computer"
            }],
            firstPlayer: "O"
        };
    });

    it('calls game engine to start game when notified about game start', () => {
        GameStartupStore.onStart(gameStartParameters);

        expect(EngineRequest.post).toBeCalledWith("http://localhost:4000/start");
    });

    it('passes game start parameters to game engine when notified about game start', () => {
        GameStartupStore.onStart(gameStartParameters);

        let parsedGameParameters = {
            o: "computer",
            x: "computer",
            first_player: "O"
        };
        expect(EngineRequest.send).toBeCalledWith(parsedGameParameters);
    });

    it('triggers game start completed with game engine start response when notified about game start', () => {
        GameStartupStore.onStart(gameStartParameters);

        let expectedGameEngineStart = {
            game_id: "123456",
            status: "start",
            players:[{
                type: "computer"
            },{
                type: "computer"
            }],
            type: "computer_computer",
            board: [null, null, null, null, null, null, null, null, null],
            nextPlayer: "O"
        };
        expect(GameActions.start.completed).toBeCalledWith(expectedGameEngineStart);
    });
});