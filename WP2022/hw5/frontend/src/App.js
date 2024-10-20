import './App.css';
import React, {useState} from 'react';
import {guess, startGame, restartGame} from './Axios'

function App() {
  const [hastarted, setHasStarted] = useState(false);
  const [hasWon, setHasWon] = useState(false);
  const [number, setNumber] = useState('');
  const [status, setStatus] = useState('');

  const handleGuess = async() => {
    const response = await guess(number)
    if(response === "equal")
      setHasWon(true)
    else{
      setStatus(response)
      setNumber('')
    }
  }
  const StartGame = async() => {
    const response = await startGame()
    if(response === "The game has started.")
      setHasStarted(true)
  }
  const Restart = async() => {
    setHasWon(false)
    setNumber('')
    setStatus('')
    const response = await restartGame()
    if(response === "The game has restarted."){
      setHasStarted(true)
      
    } 
  }
  const startMenu = 
  <div>
    <button onClick={StartGame}>Start Game</button>
  </div>
  const gameMode = 
  <div>
    <p>guess a number between 1 and 100</p>
    <input onChange={e => setNumber(e.target.value)}></input>
    <button onClick={handleGuess} disabled={!number}>guess</button>
    <p>{status}</p>
  </div>
  const winningMode = (
    <>
      <p>you won! The number was {number}.</p>
      <button onClick={Restart}>restart</button>
    </>
  )
  const game = 
  <div>
    {hasWon? winningMode : gameMode}
  </div>
  return <div className='App'>{hastarted? game : startMenu}</div>
}

export default App;
