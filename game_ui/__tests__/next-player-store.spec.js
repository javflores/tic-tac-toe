'use strict';
jest.dontMock('../components/game-requests/next-player-store.js');

const NextPlayerStore = require('../components/game-requests/next-player-store');

describe('Next Player Store', () => {
    let gameStartResponse,
        players, type;

    describe('when game starts', () => {
        beforeEach(() => {
            NextPlayerStore.trigger = jest.genMockFunction();

            type = "computer_computer";
            players = [{
                name: "R2-D2",
                type: "computer"
            },{
                name: "C-3PO",
                type: "computer"
            }];

            gameStartResponse = {
                game_id: "123456",
                status: "start",
                players: players,
                type: type,
                board: [null, null, null, null, null, null, null, null, null],
                nextPlayer: "R2-D2"
            };
        });

        it('sends listeners next player', () => {
            NextPlayerStore.onStartCompleted(gameStartResponse);

            let nextPlayer = "R2-D2";
            expect(NextPlayerStore.trigger).toBeCalledWith(nextPlayer);
        });
    });

    describe('when performing a move', () => {
        beforeEach(() => {
            players = [{
                name: "John",
                type: "human"
            },{
                name: "C-3PO",
                type: "computer"
            }];

            gameStartResponse = {
                game_id: "123456",
                status: "start",
                players: players,
                type: "human_computer",
                board: [null, null, null, null, null, null, null, null, null],
                nextPlayer: "John"
            };

            NextPlayerStore.onStartCompleted(gameStartResponse);
        });

        it('sends listeners next player upon movement performed', () => {
            NextPlayerStore.onMoveCompleted({nextPlayer: "C-3PO"});

            let nextPlayer = "C-3PO";
            expect(NextPlayerStore.trigger).toBeCalledWith(nextPlayer);
        });

        it('does not send listeners next player if game is a draw', () => {
            NextPlayerStore.trigger = jest.genMockFunction();

            NextPlayerStore.onMoveCompleted({nextPlayer: "C-3PO", status: "draw"});

            expect(NextPlayerStore.trigger).not.toBeCalled();
        });

        it('does not send listeners next player if game is a win', () => {
            NextPlayerStore.trigger = jest.genMockFunction();

            NextPlayerStore.onMoveCompleted({nextPlayer: "C-3PO", status: "win"});

            expect(NextPlayerStore.trigger).not.toBeCalled();
        });
    });
});