import Event from '../models/Event.js';

const QueryEvent = async (req, res) => {
    const { id } = req.query;
    const event = await Event.findOne({ id });
    res.send({ event: event });
}

export default QueryEvent;