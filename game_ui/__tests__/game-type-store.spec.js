'use strict';
jest.dontMock('../components/game-requests/game-type-store.js');

const GameTypeStore = require('../components/game-requests/game-type-store');

describe('When Game start players store is notified about an started game', () => {
    it('notifies listeners', () => {
        GameTypeStore.trigger = jest.genMockFunction();
        let gameStartResponse = {
            game_id: "123456",
            status: "start",
            type: "computer_computer"
        };

        GameTypeStore.onStartCompleted(gameStartResponse);

        expect(GameTypeStore.trigger).toBeCalledWith(gameStartResponse.type);
    });
});