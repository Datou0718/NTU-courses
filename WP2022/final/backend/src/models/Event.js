import mongoose from 'mongoose'

const Schema = mongoose.Schema

const EventSchema = Schema({
  id: { type: String, required: true },
  name: { type: String, required: true },
  title: { type: String, required: true },
  content: { type: String },
  start: { type: Date, required: true },
  end: { type: Date, required: true },
  allDay: { type: Boolean, required: true },
  color: { type: String, required: true },
  toDo: { type: Boolean, required: true },
  finish: { type: Boolean, required: true },
  classNames: [{ type: String }],
})

const Event = mongoose.model('Event', EventSchema);
export default Event;
