/****************************************************************************
  FileName      [ Board.js ]
  PackageName   [ src/components ]
  Author        [ Cheng-Hua Lu ]
  Synopsis      [ This file generates the Board. ]
  Copyright     [ 2022 10 ]
****************************************************************************/

import './css/Board.css'
import Cell from './Cell';
import Modal from './Modal';
import Dashboard from './Dashboard';
import { revealed } from '../util/reveal';
import createBoard from '../util/createBoard';
import React, { useEffect, useState } from 'react';


const Board = ({ boardSize, mineNum, backToHome }) => {
    const [board, setBoard] = useState([]);                     // An 2-dimentional array. It is used to store the board.
    const [nonMineCount, setNonMineCount] = useState(0);        // An integer variable to store the number of cells whose value are not '💣'.
    const [mineLocations, setMineLocations] = useState([]);     // An array to store all the coordinate of '💣'.
    const [gameOver, setGameOver] = useState(false);            // A boolean variable. If true, means you lose the game (Game over).
    const [remainFlagNum, setRemainFlagNum] = useState(0);      // An integer variable to store the number of remain flags.
    const [win, setWin] = useState(false);                      // A boolean variable. If true, means that you win the game.

    useEffect(() =>{
        if(nonMineCount === 0){
            setGameOver (true);
            setWin(true);
            return;
        }
    }, [nonMineCount]);

    useEffect(() => {
        // Calling the function
        freshBoard();
    }, []);

    const findall = (x, y, newBoard) => {
        if(x >= 0 && x < boardSize && y >= 0 && y < boardSize && newBoard[x][y].revealed === false && newBoard[x][y].value !== '💣'){
            revealCell(x, y);
        }
       return;
    }

    // Creating a board
    const freshBoard = () => {
        const newBoard = createBoard(boardSize, mineNum);
        // Basic TODO: Use `newBoard` created above to set the `Board`.
        setBoard(newBoard.board);
        setNonMineCount(boardSize*boardSize-mineNum);
        setMineLocations(newBoard.mineLocations);
        setGameOver(false);
        setRemainFlagNum(mineNum);
        // Hint: Read the definition of those Hook useState functions and make good use of them.

    }

    const restartGame = () => {
        freshBoard();
        setGameOver(false);
        setWin(false);
    }

    // On Right Click / Flag Cell
    const updateFlag = (e, x, y) => {
        // To not have a dropdown on right click
        e.preventDefault();
        // Deep copy of a state
        let newBoard = JSON.parse(JSON.stringify(board));
        let newFlagNum = remainFlagNum;
        // Basic TODO: Right Click to add a flag on board[x][y]
        if(board[x][y].flagged){
            board[x][y].flagged = !board[x][y].flagged;
            setRemainFlagNum(remainFlagNum+1);
        }
        else{
            if(remainFlagNum > 0 && !board[x][y].revealed){
                board[x][y].flagged = true;
                setRemainFlagNum(remainFlagNum-1);
            }
        }
        // Remember to check if board[x][y] is able to add a flag (remainFlagNum, board[x][y].revealed)
        // Update board and remainFlagNum in the end
    };
    
    const revealCell = (x, y) => {
        if (board[x][y].revealed || gameOver || board[x][y].flagged) return;
        let newBoard = JSON.parse(JSON.stringify(board));
        // Basic TODO: Complete the conditions of revealCell (Refer to reveal.js)
        
        if(newBoard[x][y].value === '💣'){
            for(let i = 0; i < mineNum; i++){
                newBoard[mineLocations[i][0]][mineLocations[i][1]].revealed = true;
            }
            setGameOver(true);
        }
        else{
            newBoard[x][y].revealed = true;
            setNonMineCount(e => e-1);
            
        }
        setBoard(newBoard);
        return;
        // Hint: If `Hit the mine`, check ...?
        //       Else if `Reveal the number cell`, check ...?
        // Reminder: Also remember to handle the condition that after you reveal this cell then you win the game.

    };
    return (
        <div className='boardPage' >
            <div className='boardWrapper' >
                {/* Advanced TODO: Implement Modal based on the state of `gameOver` */}
                {gameOver&&<Modal restartGame={restartGame} backToHome={backToHome} win={false}></Modal>
                }
                {/* Basic TODO: Implement Board 
                Useful Hint: The board is composed of BOARDSIZE*BOARDSIZE of Cell (2-dimention). So, nested 'map' is needed to implement the board.
                Reminder: Remember to use the component <Cell> and <Dashboard>. See Cell.js and Dashboard.js for detailed information. */}
                <div className='boardContainer'>
                    <Dashboard remainFlagNum={remainFlagNum} gameOver={gameOver}></Dashboard>
                    {
                        board.map((row, rowIDX) => {
                            return<div id="row" style={{display: "flex"}}>
                            {
                                row.map((cell, colIDX) => {
                                    return<Cell rowIdx={rowIDX} colIdx={colIDX} detail={cell} updateFlag={updateFlag} revealCell={revealCell}></Cell>
                                })
                            }
                            </div>
                        })
                    }
                </div>

            </div>
        </div>
    );



}

export default Board