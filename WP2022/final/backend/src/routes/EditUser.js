import User from '../models/User.js';
import bcrypt from 'bcrypt';

const EditUser = async (req, res) => {
  const { name, display, password } = req.body;
  let user = await User.findOne({ name });
  user.display = display;
  bcrypt.genSalt(12, (err, salt) => {
    bcrypt.hash(password, salt, async (err, hash) => {
      user.password = hash;
      await user.save();
    })
  })
  res.send({ Status: "success", Message: "Edit Sucess" });
}

export default EditUser;