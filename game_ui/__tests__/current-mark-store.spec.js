'use strict';
jest.dontMock('../components/game-requests/current-mark-store.js');

const CurrentMarkStore = require('../components/game-requests/current-mark-store');

describe('Current Mark Store', () => {
    let gameStartResponse;
    beforeEach(() => {
        CurrentMarkStore.trigger = jest.genMockFunction();

        gameStartResponse = {
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
    });

    it('sets initial current mark of listeners upon game start', () => {
        CurrentMarkStore.onStartCompleted(gameStartResponse);

        let initialMark = CurrentMarkStore.getInitialState();

        let markFirstPlayer = "O";
        expect(initialMark).toEqual(markFirstPlayer);
    });

    it('sends listeners the starting mark upon game started', () => {
        CurrentMarkStore.onStartCompleted(gameStartResponse);

        let markFirstPlayer = "O";
        expect(CurrentMarkStore.trigger).toBeCalledWith(markFirstPlayer);
    });

    it('sends listeners the next mark upon movement performed', () => {
        CurrentMarkStore.onStartCompleted(gameStartResponse);

        CurrentMarkStore.onMoveCompleted({nextPlayer: "X"});

        let markNextPlayer = "X";
        expect(CurrentMarkStore.trigger).toBeCalledWith(markNextPlayer);
    });
});