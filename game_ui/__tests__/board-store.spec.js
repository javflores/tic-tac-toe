'use strict';
jest.dontMock('../components/game-requests/board-store.js');

const BoardStore = require('../components/game-requests/board-store');

describe('Board store', () => {

    let gameStartResponse;
    beforeEach(() => {
        BoardStore.trigger = jest.genMockFunction();

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
            next_player: "R2-D2"
        };
    });

    it('sends listeners a new board upon game started', () => {

        BoardStore.onStartCompleted(gameStartResponse);

        expect(BoardStore.trigger).toBeCalledWith(gameStartResponse.board);
    });

    it('sends listeners next board upon movement completed', () => {
        let move = {board: ["x", null, null, null, null, null, null, null, null]};

        BoardStore.onMoveCompleted(move);

        expect(BoardStore.trigger).toBeCalledWith(move.board);
    });
});