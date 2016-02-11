'use strict';
import React from 'react';
import { render } from 'react-dom';
import Modal from 'react-modal';

const Draw = React.createClass({
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
                width: '300px',
                height: '230px',
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
            <Modal
                isOpen={true}
                style={this.getStyle()}>
                <h2>The battle was hard...</h2>
                <div className="row">
                    <div className="col-lg-12">
                        <h2 className="subheader">This is draw!</h2>
                    </div>
                </div>
                <button className="btn btn-primary" onClick={this.props.restartGame}>Start new game</button>
            </Modal>
        );
    }
});

module.exports = Draw;