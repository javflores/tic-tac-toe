'use strict';
jest.dontMock('../components/game-requests/next-player-store.js');

let GameActions = require('../components/game-requests/game-actions');

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

        it('stores the start players', () => {
            NextPlayerStore.onStartCompleted(gameStartResponse);

            expect(NextPlayerStore.data.players).toEqual(players);
        });

        it('stores the type of game', () => {
            NextPlayerStore.onStartCompleted(gameStartResponse);

            expect(NextPlayerStore.data.type).toEqual(type);
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

        it('triggers a move if next player is computer and previous player was human', () => {
            GameActions.move = jest.genMockFunction();

            NextPlayerStore.onMoveCompleted({nextPlayer: "C-3PO"});

            expect(GameActions.computerMove).toBeCalled();
        });
    });
});