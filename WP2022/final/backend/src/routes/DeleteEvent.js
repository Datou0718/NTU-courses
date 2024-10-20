import Event from '../models/Event.js'

const DeleteEvent = async (req, res) => {
    const { id } = req.body;
    await Event.deleteOne({ id });
    res.send({ Status: "success", Message: "Delete Success" });
}

export default DeleteEvent;