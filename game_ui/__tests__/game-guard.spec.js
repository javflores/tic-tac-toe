'use strict';
jest.dontMock('../components/game-guard');

import {GameGuard} from '../components/game-guard';

describe('Game guard', () => {
    let action,
        guard;
    beforeEach(() => {
        guard = new GameGuard();
        action = jest.genMockFunction();
    });

    it('enables action', () => {
        guard.deactivate();

        guard.guard(action);

        expect(action).toBeCalled();
    });

    it('disables action', () => {
        guard.activate();

        guard.guard(action);

        expect(action).not.toBeCalled();
    });
});