'use strict';

var mockDelay;
var mockError;
var mockResponse = {
    status() {
        return 200;
    },
    ok() {
        return true;
    },
    body(){
        return {
            "game_id": "123456",
            "status": "start",
            "type": "computer_computer",
            "o": "R2-D2",
            "x": "C-3PO",
            "board": [null, null, null, null, null, null, null, null, null],
            "next_player": "R2-D2"
        };
    },
    get: jest.genMockFunction(),
    toError: jest.genMockFunction()
};

var GameEngineMock = {
    post : jest.genMockFunction().mockImplementation(function(){
        return this;
    }),
    send : jest.genMockFunction().mockImplementation(function(){
        return this;
    }),
    set() {
        return this;
    },
    accept() {
        return this;
    },
    type() {
        return this;
    },
    timeout() {
        return this;
    },
    end: jest.genMockFunction().mockImplementation(function(callback) {
        if (mockDelay) {
            this.delayTimer = setTimeout(callback, 0, mockError, mockResponse);

            return;
        }

        callback(mockError, mockResponse);
    }),
    __setMockDelay(boolValue) {
        mockDelay = boolValue;
    },
    __setMockResponse(mockRes) {
        mockResponse = mockRes;
    },
    __setMockError(mockErr) {
        mockErr = mockErr;
    }
};

module.exports = GameEngineMock;