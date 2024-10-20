import { Router } from "express";
import ScoreCard from "../models/ScoreCard";
const router = Router();
router.post('/card', async (req, res) => {
	console.log("request data is: ", req.body);
	const isExist = await ScoreCard.findOne({
		name: req.body.name,
		subject: req.body.subject
	});
	if(isExist){
		console.log('Exist a card: ', isExist);
		isExist.score = req.body.score;
		res.json({message: `Updating (${req.body.name}, ${req.body.subject}, ${req.body.score})`, card: req.body});
		return isExist.save();
	}
	try {
		const newCard = new ScoreCard(req.body);
		res.json({message: `Adding (${req.body.name}, ${req.body.subject}, ${req.body.score})`, card: req.body});
		return newCard.save();
	} catch (e) { throw new Error (e); }
})

router.get('/cards', async (req, res) => {
	console.log("request data is: ", req.query);
	if(req.query.type === 'name'){
		const isExist = await ScoreCard.find({name: req.query.queryString})
		if(isExist) console.log(isExist);
		let ret = []
		for(let i = 0; i < isExist.length; i++)
			ret.push(`Found card with name: (${isExist[i].name}, ${isExist[i].subject}, ${isExist[i].score})`);
		if(!ret.length) ret = null;
		res.json({messages: ret, message: `Name (${req.query.queryString}) not found!`});
	} else {
		const isExist = await ScoreCard.find({subject: req.query.queryString})
		if(isExist) console.log(isExist);
		let ret = []
		for(let i = 0; i < isExist.length; i++)
			ret.push(`Found card with subject: (${isExist[i].name}, ${isExist[i].subject}, ${isExist[i].score})`);
		if(!ret.length) ret = null;
		res.json({messages: ret, message: `Subject (${req.query.queryString}) not found!`});
	}
})

router.delete('/cards', async (_, res) => {
	try { 
		await ScoreCard.deleteMany({});
		res.json({message: 'Database cleared'});
	} catch (e) {throw new Error(e)};
})

router.get('/',(_, res) => {
	res.send('yoyoyo')
})

export default router;