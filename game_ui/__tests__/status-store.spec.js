'use strict';
jest.dontMock('../components/game-requests/status-store.js');

const GameStatusStore = require('../components/game-requests/status-store');

describe('Status store', () => {
    let gameStartResponse;
    beforeEach(() => {
        GameStatusStore.trigger = jest.genMockFunction();

        gameStartResponse = {
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
    });

    it('notifies listeners about a started game upon start', () => {
        GameStatusStore.onStartCompleted(gameStartResponse);

        expect(GameStatusStore.trigger).toBeCalledWith(gameStartResponse.status);
    });

    it('notifies listeners about next status upon movement performed', () => {
        GameStatusStore.onStartCompleted(gameStartResponse);

        let inProgressStatus = "in_progress";
        GameStatusStore.onMoveCompleted({status: inProgressStatus});

        expect(GameStatusStore.trigger).toBeCalledWith(inProgressStatus);
    });
});