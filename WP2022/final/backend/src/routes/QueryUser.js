import User from '../models/User.js';
import Event from '../models/Event.js';
import bcrypt from 'bcrypt';

const QueryUser = async (req, res) => {
  const { name, password } = req.query;
  const user = await User.findOne({ name });
  if(user === null)
    res.send({ Status: "error", Message: "No such user", Events: [] });
  else{
    bcrypt.compare(password, user.password, async (err, res_) => {
      if (res_) {
        const events = await Event.find({ name });
        const toDos = events.filter((t) => t.toDo === true);
        res.send({ Status: "success", Message: "Log in success", Events: events, ToDos: toDos, Display: user.display });
      }else {
        res.send({ Status: "error", Message: "Password incorrect", Events: [] });
      }
    })
  }
}

export default QueryUser;