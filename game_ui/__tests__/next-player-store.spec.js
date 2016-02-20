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
                type: "computer"
            },{
                type: "computer"
            }];

            gameStartResponse = {
                game_id: "123456",
                status: "start",
                players: players,
                type: type,
                board: [null, null, null, null, null, null, null, null, null],
                nextPlayer: "O"
            };
        });

        it('sends listeners next player', () => {
            NextPlayerStore.onStartCompleted(gameStartResponse);

            let nextPlayer = "O";
            expect(NextPlayerStore.trigger).toBeCalledWith(nextPlayer);
        });
    });

    describe('when performing a move', () => {
        beforeEach(() => {
            players = [{
                type: "human"
            },{
                type: "computer"
            }];

            gameStartResponse = {
                game_id: "123456",
                status: "start",
                players: players,
                type: "human_computer",
                board: [null, null, null, null, null, null, null, null, null],
                nextPlayer: "O"
            };

            NextPlayerStore.onStartCompleted(gameStartResponse);
        });

        it('sends listeners next player upon movement performed', () => {
            NextPlayerStore.onMoveCompleted({nextPlayer: "X"});

            let nextPlayer = "X";
            expect(NextPlayerStore.trigger).toBeCalledWith(nextPlayer);
        });

        it('does not send listeners next player if game is a draw', () => {
            NextPlayerStore.trigger = jest.genMockFunction();

            NextPlayerStore.onMoveCompleted({nextPlayer: "X", status: "draw"});

            expect(NextPlayerStore.trigger).not.toBeCalled();
        });

        it('does not send listeners next player if game is a win', () => {
            NextPlayerStore.trigger = jest.genMockFunction();

            NextPlayerStore.onMoveCompleted({nextPlayer: "X", status: "win"});

            expect(NextPlayerStore.trigger).not.toBeCalled();
        });
    });
});