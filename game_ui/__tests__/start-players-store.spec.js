'use strict';
jest.dontMock('../components/game-requests/start-players-store.js');

const GameStartPlayersStore = require('../components/game-requests/start-players-store');

describe('When Game start players store is notified about an started game', () => {
    it('notifies listeners', () => {
        GameStartPlayersStore.trigger = jest.genMockFunction();

        let gameStartResponse = {
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
        GameStartPlayersStore.onStartCompleted(gameStartResponse);

        expect(GameStartPlayersStore.trigger).toBeCalledWith(gameStartResponse.players);
    });
});