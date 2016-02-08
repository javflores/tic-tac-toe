'use strict';
jest.dontMock('../components/game-requests/next-player-store.js');

const NextPlayerStore = require('../components/game-requests/next-player-store');

describe('Next Player Store', () => {
    let gameStartResponse;
    beforeEach(() => {
        NextPlayerStore.trigger = jest.genMockFunction();

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

    it('sends listeners next player upon game started', () => {
        NextPlayerStore.onStartCompleted(gameStartResponse);

        let nextPlayer = "R2-D2";
        expect(NextPlayerStore.trigger).toBeCalledWith(nextPlayer);
    });

    it('sends listeners next player upon movement performed', () => {
        NextPlayerStore.onStartCompleted(gameStartResponse);

        NextPlayerStore.onMoveCompleted({nextPlayer: "C-3PO"});

        let nextPlayer = "C-3PO";
        expect(NextPlayerStore.trigger).toBeCalledWith(nextPlayer);
    });
});