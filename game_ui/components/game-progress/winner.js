'use strict';
import React from 'react';
import { render } from 'react-dom';
import Modal from 'react-modal';

const Winner = React.createClass({
    restartGame(option){
        this.props.restartGame(option);
    },

    getStyle(){
        return {
            overlay : {
                position          : 'fixed',
                top               : 0,
                left              : 0,
                right             : 0,
                bottom            : 0,
                backgroundColor   : 'rgba(20, 20, 20, 0.802)'
            },
            content : {
                width: '315px',
                height: '300px',
                padding: '10px 30px 30px 30px',
                top: '67%',
                left: '50%',
                right: 'auto',
                bottom: 'auto',
                marginRight: '-50%',
                transform: 'translate(-50%, -50%)',
                background: '#FFFFFF',
                overflow: 'hidden'
            }
        };
    },

    render() {
        return (
            <div>
                <Modal
                    isOpen={true}
                    style={this.getStyle()}>
                    <h2>And the game goes to...</h2>
                    <div className="row">
                        <div className="col-lg-12">
                            <h2 className="subheader">{this.props.winner}</h2>
                        </div>
                    </div>
                    <button className="btn btn-primary" onClick={this.restartGame.bind(this, "repeat")}>Start new game with same selection</button>
                    <button className="btn btn-primary" onClick={this.restartGame.bind(this, "new")}>Start new game</button>
                </Modal>
            </div>
        );
    }
});

module.exports = Winner;