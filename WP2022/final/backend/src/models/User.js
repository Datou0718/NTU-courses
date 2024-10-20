import mongoose from 'mongoose'

const Schema = mongoose.Schema

const UserSchema = Schema({
  name: { type: String, required: true },
  display: { type: String, required: true },
  password: { type: String, required: true },
})

const User = mongoose.model('User', UserSchema);
export default User;
