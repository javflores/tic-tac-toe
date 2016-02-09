'use strict';

const Activated = "activate";

export class GameGuard {
    constructor() {
        this.flags = {};
    }

    deactivate(){
        this.flags[Activated] = false;
    }

    activate(){
        this.flags[Activated] = true;
    }

    guard(action){
        if(!this.flags[Activated]){
            return action.apply(this, arguments);
        }
    }
}