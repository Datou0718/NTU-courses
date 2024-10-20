import Event from '../models/Event.js'

const UpdateEvent = async (req, res) => {
  const { event } = req.body;
  const id = event.id;
  let newEvent = await Event.findOne({ id });
  newEvent.name = event.name;
  newEvent.title = event.title;
  newEvent.content = event.content;
  newEvent.start = event.start;
  newEvent.end = event.end;
  newEvent.allDay = event.allDay;
  newEvent.color = event.color;
  newEvent.toDo = event.toDo;
  newEvent.finish = event.finish;
  newEvent.classNames = event.classNames;
  await newEvent.save();
  res.send({ Status: "success", Message: "Update Success" });
}

export default UpdateEvent;