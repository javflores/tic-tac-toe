'use strict';
jest.dontMock('../components/game-requests/game-start-players-store.js');

const GameStartPlayersStore = require('../components/game-requests/game-start-players-store');

describe('When Game start players store is notified about an started game', () => {
    it('notifies listeners', () => {
        GameStartPlayersStore.trigger = jest.genMockFunction();

        let gameStartResponse = {
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
        GameStartPlayersStore.onGameStart(gameStartResponse);

        expect(GameStartPlayersStore.trigger).toBeCalledWith({
            players: gameStartResponse.players,
            nextPlayer: gameStartResponse.nextPlayer
        });
    });
});