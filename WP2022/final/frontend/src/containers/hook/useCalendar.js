import { useState ,useEffect, createContext, useContext } from "react";
import { message } from "antd";

import axios from "../../axios.js";

const CalendarContext = createContext({
  status: {},
  me: "",
  display: "",
  logIn: false,
  events: [],
  toDos: [],
  newUser: () => {},
  checkUser: () => {},
  editUser: () => {},
  getEventInfo: () => {},
  newEvent: () => {},
  updateEvent: () => {},
  deleteEvent: () => {},
  displayStatus: () => {}
});

const CalendarProvider = (props) => {

  const savedLogIn = localStorage.getItem('logIn');
  const savedMe = localStorage.getItem('user');

  const [status, setStatus] = useState({});
  const [me, setMe] = useState(savedMe);
  const [display, setDisplay] = useState('');
  const [logIn, setLogIn] = useState(savedLogIn);
  const [events, setEvents] = useState([]);
  const [toDos, setToDos] = useState([]);

  useEffect(() => {
    if(savedLogIn === 'true'){
      getUser(me);
    }
  }, []);

  const displayStatus = (s, m) => {
    const content = {content: m, duration: 2.5};
    switch(s){
      case 'success':
      message.success(content);
      break;
      case 'error':
      default:
      message.error(content);
      break;
      case 'info':
      message.info(content);
      break;
    }
  }

  const newUser = async (name, password) => {
    const {
      data: { Status, Message },
    } = await axios.post('/Register', {
      name: name,
      display: name,
      password: password
    });
    displayStatus(Status, Message);
    if(Status === "error")
      return false;
    else
      return true;
  }

  const checkUser = async (name, password) => {
    const {
      data: { Status, Message, Events, ToDos, Display },
    } = await axios.get('/Check', {
      params: {
        name: name,
        password: password
      }
    });
    displayStatus(Status, Message);
    setEvents(Events);
    setDisplay(Display);
    if(ToDos && ToDos.length !== 0)
      setToDos(ToDos.sort((a, b) => {return new Date(a.end) - new Date(b.end)}));
    if(Status === "error")
      return false;
    else
      return true;
  }

  const getUser = async (name) => {
    const {
      data: { Events, ToDos, User },
    } = await axios.get('/GetUserInfo', {
      params: {
        name: name,
      }
    });
    setEvents(Events);
    if(ToDos && ToDos.length !== 0)
      setToDos(ToDos.sort((a, b) => {return new Date(a.end) - new Date(b.end)}));
    setDisplay(User.display);
  }

  const editUser = async (name, display, password) => {
    const {
      data: { Status, Message },
    } = await axios.post('/EditUser', {
      name: name,
      display: display,
      password: password
    });
    displayStatus(Status, Message);
  }

  const getEventInfo = async (id) => {
    const {
      data: { event },
    } = await axios.get('/QueryEvent', {
      params: {
        id: id,
      }
    });
    return event;
  }

  const newEvent = async (e) => {
    const {
      data: { Status, Message },
    } = await axios.post('/AddEvent', {
      event: e
    });
    displayStatus(Status, Message);
  }

  const updateEvent = async (e, m) => {
    const {
      data: { Status, Message },
    } = await axios.post('/UpdateEvent', {
      event: e
    });
    if(m !== 'todo')
      displayStatus(Status, Message);
  }

  const deleteEvent = async (e) => {
    const {
      data: { Status, Message },
    } = await axios.post('/DeleteEvent', {
      id: e.id,
    });
    displayStatus(Status, Message)
  }
    
  return (
    <CalendarContext.Provider
      value={{status, me, display, logIn, events, toDos, setMe, setDisplay, setLogIn, setEvents, setToDos, 
              newUser, checkUser, editUser, getEventInfo, newEvent, updateEvent, deleteEvent, displayStatus}}
      {...props}
    />
  );
};

const useCalendar = () => useContext(CalendarContext);

export {CalendarProvider, useCalendar};
