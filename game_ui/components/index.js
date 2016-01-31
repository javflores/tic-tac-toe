'use strict';
import React from 'react';
import { render } from 'react-dom';
import { Router, Route, Link, browserHistory } from 'react-router';

const App = React.createClass({
    render() {
        return (
            <div>
                <h1>Welcome to TicTacToe</h1>
            </div>
        );
    }
});

render((
    <Router history={browserHistory}>
        <Route path="/" component={App}>
        </Route>
    </Router>
), document.getElementById("tic-tac-toe"));

