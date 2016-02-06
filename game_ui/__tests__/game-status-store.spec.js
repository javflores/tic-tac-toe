'use strict';
jest.dontMock('../components/game-requests/game-status-store.js');

const GameStatusStore = require('../components/game-requests/game-status-store');

describe('When Game is notified about an started game', () => {
    it('notifies listeners', () => {
        GameStatusStore.trigger = jest.genMockFunction();

        let gameStartResponse = {
            game_id: "123456",
            status: "start",
            type: "computer_computer",
            o: "R2-D2",
            x: "C-3PO",
            board: [null, null, null, null, null, null, null, null, null],
            next_player: "R2-D2"
        };
        GameStatusStore.onGameStart(gameStartResponse);

        expect(GameStatusStore.trigger).toBeCalledWith(gameStartResponse.status);
    });
});