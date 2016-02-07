'use strict';
jest.dontMock('../components/game-requests/current-mark-store.js');

const CurrentMarkStore = require('../components/game-requests/current-mark-store');

describe('When Current Mark Store is notified about an started game', () => {
    it('sends listeners the starting mark', () => {
        CurrentMarkStore.trigger = jest.genMockFunction();

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
        CurrentMarkStore.onGameStart(gameStartResponse);

        expect(CurrentMarkStore.trigger).toBeCalledWith("o");
    });
});