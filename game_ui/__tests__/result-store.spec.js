'use strict';
jest.dontMock('../components/game-requests/result-store.js');

const ResultStore = require('../components/game-requests/result-store');

describe('When game is not a draw nor has a winner', () => {
    it('does not notify listeners', () => {
        ResultStore.trigger = jest.genMockFunction();
        let gameStatus = "in_progress";

        ResultStore.onMoveCompleted({status: gameStatus});

        expect(ResultStore.trigger).not.toBeCalled();
    });
});

describe('When game is a draw', () => {
    it('notifies listeners', () => {
        ResultStore.trigger = jest.genMockFunction();
        let drawStatus = "draw";

        ResultStore.onMoveCompleted({status: drawStatus});

        expect(ResultStore.trigger).toBeCalledWith({result: drawStatus});
    });
});

describe('When game is a winner', () => {
    it('notifies listeners about the winner', () => {
        ResultStore.trigger = jest.genMockFunction();
        let moveResult = {
            status: "winner",
            player: "John"
        };

        ResultStore.onMoveCompleted(moveResult);

        expect(ResultStore.trigger).toBeCalledWith({result: "winner", winner: "John"});
    });
});