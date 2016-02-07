'use strict';
jest.dontMock('../components/game-requests/board-store.js');

const BoardStore = require('../components/game-requests/board-store');

describe('When Board store is notified about an started game', () => {
    it('sends listeners a new board', () => {
        BoardStore.trigger = jest.genMockFunction();

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
            next_player: "R2-D2"
        };
        BoardStore.onGameStart(gameStartResponse);

        expect(BoardStore.trigger).toBeCalledWith(gameStartResponse.board);
    });
});