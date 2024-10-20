/****************************************************************************
  FileName      [ Modal.js ]
  PackageName   [ src/components ]
  Author        [ Cheng-Hua Lu ]
  Synopsis      [ This file generates the Modal component. ]
  Copyright     [ 2022 10 ]
****************************************************************************/

import './css/Modal.css'
import React, { useEffect, useState } from "react";

export default function Modal({ restartGame, backToHome, win }) {
    const [render, setRender] = useState(false);
    useEffect(() => {
        setTimeout(() => {
            setRender(true);
        }, 1000);
    }, []);

    return (
        // Advanced TODO: Implement the structure of Modal
        <div className='modal'>
            <div className='modalWrapper'></div>
            <div className='modalContent'>
                <div className='modalResult'>{win ? (<span>WIN</span>) : (<span>Game Over</span>)}</div>
                <div className='modalBtnWrapper'>
                    <div className='modalBtn' onClick={restartGame}>{win? <span>New Game</span> : <span>Try Again</span>}</div>
                    <div className='modalBtn' onClick={backToHome}><span>Back to Home</span></div>
                </div>
            </div>
            <div className='modalWrapper'></div>
        </div>
        // Useful Hint: style = {{opacity: 1 or 0 }}
        
    );
}