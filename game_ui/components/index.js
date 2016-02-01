'use strict';
import React from 'react';
import { render } from 'react-dom';
import { Router, Route, Link, browserHistory } from 'react-router';
var TicTacToe = require('../components/tictactoe');

render((
    <Router history={browserHistory}>
        <Route path="/" component={TicTacToe}>
        </Route>
    </Router>
), document.getElementById("tic-tac-toe"));

