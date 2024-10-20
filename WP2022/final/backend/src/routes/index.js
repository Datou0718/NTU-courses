import express from "express"

import CreateUser from "./CreateUser.js";
import QueryUser from "./QueryUser.js";
import GetUser from "./GetUser.js";
import EditUser from "./EditUser.js";
import QueryEvent from "./QueryEvent.js";
import AddEvent from "./AddEvent.js";
import UpdateEvent from "./UpdateEvent.js";
import DeleteEvent from "./DeleteEvent.js";

const routes = express.Router();

routes.post('/Register', (req, res) => { CreateUser(req, res) });
routes.get('/Check', (req, res) => { QueryUser(req, res) });
routes.get('/GetUserInfo', (req, res) => { GetUser(req, res) });
routes.post('/EditUser', (req, res) => { EditUser(req, res) });
routes.get('/QueryEvent', (req, res) => { QueryEvent(req, res) });
routes.post('/AddEvent', (req, res) => { AddEvent(req, res) });
routes.post('/UpdateEvent', (req, res) => { UpdateEvent(req, res) });
routes.post('/DeleteEvent', (req, res) => { DeleteEvent(req, res) });

export default routes;