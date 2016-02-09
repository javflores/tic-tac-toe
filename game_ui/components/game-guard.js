'use strict';

export class GameGuard {
    constructor() {
        this.activated = false;
    }

    deactivate(){
        this.activated = false;
    }

    activate(){
        this.activated = true;
    }

    guard(action){
        if(this.activated){
            return;
        }

        return action.apply(this, arguments);
    }
}