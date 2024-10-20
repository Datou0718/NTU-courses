/****************************************************************************
  FileName      [ Board.js ]
  PackageName   [ src/components ]
  Author        [ Cheng-Hua Lu ]
  Synopsis      [ This file generates the Board. ]
  Copyright     [ 2022 10 ]
****************************************************************************/

import Row from "./Row";
import './css/Board.css';
import React from "react";
import CurRow from "./CurRow";

var cnt = 0;

const Board = ({ turn, guesses, curGuess }) => {
    return (
        <div className="Board-container">
            {/* TODO 2-2: show 6 rows (map function is recommended) and defined row's key.
                Hint: Use `CurRow` instead of `Row` when you are passing `curGuess` into it. */}
            {0 === turn? 
            <CurRow id = {"row_"+0} key = {"row_"+0} curGuess = {guesses[0]} rowIdx = {0}></CurRow> :
            <Row id = {"row_"+0} key = {"row_"+0} guess = {guesses[0]} rowIdx = {0}></Row>}
            {1 === turn? 
            <CurRow id = {"row_"+1} key = {"row_"+1} curGuess = {guesses[1]} rowIdx = {1}></CurRow> :
            <Row id = {"row_"+1} key = {"row_"+1} guess = {guesses[1]} rowIdx = {1}></Row>}
            {2 === turn? 
            <CurRow id = {"row_"+2} key = {"row_"+2} curGuess = {guesses[2]} rowIdx = {2}></CurRow> :
            <Row id = {"row_"+2} key = {"row_"+2} guess = {guesses[2]} rowIdx = {2}></Row>}
            {3 === turn? 
            <CurRow id = {"row_"+3} key = {"row_"+3} curGuess = {guesses[3]} rowIdx = {3}></CurRow> :
            <Row id = {"row_"+3} key = {"row_"+3} guess = {guesses[3]} rowIdx = {3}></Row>}
            {4 === turn? 
            <CurRow id = {"row_"+4} key = {"row_"+4} curGuess = {guesses[4]} rowIdx = {4}></CurRow> :
            <Row id = {"row_"+4} key = {"row_"+4} guess = {guesses[4]} rowIdx = {4}></Row>}
            {5 === turn? 
            <CurRow id = {"row_"+5} key = {"row_"+5} curGuess = {guesses[5]} rowIdx = {5}></CurRow> :
            <Row id = {"row_"+5} key = {"row_"+5} guess = {guesses[5]} rowIdx = {5}></Row>}


        </div>
    )
};
export default Board;
