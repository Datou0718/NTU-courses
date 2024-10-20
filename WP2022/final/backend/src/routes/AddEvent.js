import Event from '../models/Event.js'

const AddEvent = async (req, res) => {
  const { event } = req.body;
  await new Event(event).save();
  res.send({ Status: "success", Message: "Add Success" });
}

export default AddEvent;