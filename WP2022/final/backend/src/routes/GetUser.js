import Event from '../models/Event.js';
import User from '../models/User.js';

const GetUser = async (req, res) => {
  const { name } = req.query;  
  const events = await Event.find({ name });
  const toDos = events.filter((t) => t.toDo === true);
  const user = await User.findOne({ name });
  res.send({ Events: events, ToDos: toDos, User: user });
}

export default GetUser;