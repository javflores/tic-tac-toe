'use strict';
jest.dontMock('../components/game-requests/game-store.js');

var EngineRequest = require('superagent');
const GameStore = require('../components/game-requests/game-store');


describe('When Game store is notified about game start', () => {
    let gameStartParameters;
    beforeEach(() => {
        gameStartParameters = {
            players: [{
                name: "R2-D2",
                type: "Computer"
            },{
                name: "C-3PO",
                type: "Computer"
            }],
            firstPlayer: "R2-D2"
        };
    });

    it('calls game engine to start game', () => {
        GameStore.onStart(gameStartParameters);

        expect(EngineRequest.post).toBeCalledWith("localhost:4000/start");
    });

    it('passes game start parameters to game engine', () => {
        GameStore.onStart(gameStartParameters);

        let parsedGameParameters = {
            o_name: "R2-D2",
            o_type: "computer",
            x_name: "C-3PO",
            x_type: "computer",
            first_player: "R2-D2"
        };
        expect(EngineRequest.send).toBeCalledWith(parsedGameParameters);
    });

    it('notifies listeners when game has started', () => {
        GameStore.trigger = jest.genMockFunction();

        GameStore.onStart(gameStartParameters);

        let expectedGameEngineStart = {
            "game_id": "123456",
            "status": "start",
            "type": "computer_computer",
            "o": "R2-D2",
            "x": "C-3PO",
            "board": [null, null, null, null, null, null, null, null, null],
            "next_player": "R2-D2"
        };
        expect(GameStore.trigger).toBeCalledWith(expectedGameEngineStart);
    });
});