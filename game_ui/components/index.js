'use strict';
import React from 'react';
import { render } from 'react-dom';
import { Router, Route, Link, browserHistory } from 'react-router';

const App = React.createClass({
    render() {
        return (
            <div>
                <div className="row">
                    <div className="col-lg-12 title">
                        <h1 className="subheader">Tic Tac Toe</h1>
                        <h4 className="subheader">Let's get some fun.</h4>
                    </div>
                </div>

                <div className="row">
                    <div className="board-container col-lg-6 col-sm-6">
                        <table className="board">
                            <tbody>
                                <tr id="row1">
                                    <td className="square"/>
                                    <td className="square v"/>
                                    <td className="square"/>
                                </tr>
                                <tr id="row2">
                                    <td className="square h"/>
                                    <td className="square middle"/>
                                    <td className="square h"/>
                                </tr>
                                <tr id="row3">
                                    <td className="square"/>
                                    <td className="square v"/>
                                    <td className="square"/>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div className="row">
                    <div className="row">
                        <div className="col-lg-12 title">
                            <h4 className="game-control subheader">Select players</h4>
                        </div>
                    </div>
                    <div className="col-lg-4 col-sm-4 control">
                        <a className="computer">
                            <i className="fa fa-laptop fa-5x"/>
                            <p>Computer</p>
                        </a>
                    </div>
                    <div className="col-lg-4 col-sm-4 control">
                        <h3 className="subheader prompt">VS</h3>
                    </div>
                    <div className="col-lg-4 col-sm-4 control">
                        <a className="human">
                            <i className="fa fa-user fa-5x"/>
                            <p>Human</p></a>
                    </div>
                </div>
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

