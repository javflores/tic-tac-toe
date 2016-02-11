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

    it('sets initial current mark of listeners upon game start', () => {
        CurrentMarkStore.onStartCompleted(gameStartResponse);

        let initialMark = CurrentMarkStore.getInitialState();

        let markFirstPlayer = "o";
        expect(initialMark).toEqual(markFirstPlayer);
    });

    it('sends listeners the starting mark upon game started', () => {
        CurrentMarkStore.onStartCompleted(gameStartResponse);

        let markFirstPlayer = "o";
        expect(CurrentMarkStore.trigger).toBeCalledWith(markFirstPlayer);
    });

    it('sends listeners the next mark upon movement performed', () => {
        CurrentMarkStore.onStartCompleted(gameStartResponse);

        CurrentMarkStore.onMoveCompleted({nextPlayer: "C-3PO"});

        let markNextPlayer = "x";
        expect(CurrentMarkStore.trigger).toBeCalledWith(markNextPlayer);
    });
});