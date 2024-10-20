import express from 'express'
import {getNumber, genNumber} from '../core/getNumber'
const router = express.Router()

router.post('/start', (_, res) => {
    genNumber()
    res.json({msg: "The game has started."})
})
router.get('/guess', (req, res) => {
    var answer = getNumber()
    var guessNumber = req.query.number
    if(isNaN(guessNumber) || guessNumber > 100 || guessNumber < 1)
        res.status(406).send({msg: 'Not a legal number.'})
    else if(guessNumber > answer)
        res.send({msg: 'Smaller'})
    else if(guessNumber < answer)
        res.send({msg: 'Larger'})
    else
        res.send({msg: 'equal'})
})
router.post('/restart', (_, res) => {
    genNumber()
    res.json({msg: "The game has restarted."})
})
export default router