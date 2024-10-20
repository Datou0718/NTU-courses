import User from '../models/User.js';
import bcrypt from 'bcrypt';

const CreateUser = async (req, res) => {
  const { name, display, password } = req.body;
  let user = await User.findOne({ name });
  if(user)
    res.send({ Status: "error", Message: "This name exists" });
  else{
    user = new User({ name, display });
    bcrypt.genSalt(12, (err, salt) => {
      bcrypt.hash(password, salt, async (err, hash) => {
        user.password = hash;
        await user.save();
      })
    })
    res.send({ Status: "success", Message: "Register Sucess"});
  }
}

export default CreateUser;