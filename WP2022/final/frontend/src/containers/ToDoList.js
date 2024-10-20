import { Checkbox, List, Button, Form, Select, Tag } from "antd";
import { useState, useEffect } from "react";
import { DeleteOutlined } from '@ant-design/icons';
import dayjs from "dayjs";

import '../css/ToDoList.css'
import { useCalendar } from "./hook/useCalendar";
import InfoModal from "./InfoModal";
import EventModal from "./EventModal";

const ToDOList = () => {
  const { events, setEvents ,toDos, setToDos, getEventInfo, deleteEvent, updateEvent } = useCalendar();
  const [infoModal, setInfoModal] = useState(false);
  const [eventModal, setEventModal] = useState(false);
  const [event, setEvent] = useState({});
  const [show, setShow] = useState(toDos);
  const [color, setColor] = useState([]);
  const [form] = Form.useForm();

  useEffect(() => {
    if(color.length === 0)
      setShow(toDos);
    else{
      const newShow = toDos.filter((t) => color.includes(t.color));
      setShow(newShow);
    }
  }, [toDos, color]);

  const options = 
  [{ value: 'red', label: 'red' }, { value: 'orange', label: 'orange' }, { value: 'plum', label: 'light purple' }, { value: 'purple', label: 'purple' }
  ,{ value:'green', label: 'green' }, { value:'darkseagreen', label: 'light green' }, { value:'lightpink', label: 'light pink' }, { value:'skyblue', label: 'sky blue' }];
  const tagRender = (props) => {
    const { label, value, closable, onClose } = props;
    const onPreventMouseDown = (event) => {
      event.preventDefault();
      event.stopPropagation();
    };
    return (
      <Tag
        color={value}
        onMouseDown={onPreventMouseDown}
        closable={closable}
        onClose={onClose}
        style={{ marginRight: 3 }}
      >
        {label}
      </Tag>
    );
  };

  return (
    <>
    <div className="listContainer">
      <List
        className="toDoList"
        header={
          <Select
            mode="multiple"
            showArrow
            tagRender={ tagRender }
            style={{ width: '100%' }}
            options={ options }
            onChange={(e) => {
              setColor(e);
            }}
          />
        }
        bordered
        dataSource={show}
        renderItem={(item) => (
          <List.Item>
            <div>
              <Checkbox checked={item.finish} onChange={(e) => {
                const newEvents = events.map((m) => {
                  if(m.id === item.id){
                    m.finish = e.target.checked;
                    m.classNames = e.target.checked? ['finish']: []; 
                  }
                  return m;
                });
                setEvents(newEvents);
                const newTodos = toDos.map((m) => {
                  if(m.id === item.id){
                    m.finish = e.target.checked;
                    m.classNames = e.target.checked? ['finish']: [];
                  }
                  return m;
                });
                setToDos(newTodos);
                let newEvent = item;
                newEvent.finish = e.target.checked;
                newEvent.classNames = e.target.checked? ['finish']: [];
                updateEvent(newEvent, 'todo');
              }}/>
              <Button type="link" style={{color: 'black'}} onClick={async () => {
                let info = await getEventInfo(item.id);
                setInfoModal(true);
                info.start = dayjs(info.start);
                info.end = (info.allDay)? dayjs(info.end).subtract(1, "day"): dayjs(info.end);
                setEvent(info);
              }}>
                <p style={{textDecoration: item.finish? 'line-through': 'initial'}}>{item.title}</p>
              </Button>
            </div>
            <Button type="text" icon={<DeleteOutlined />} onClick={() => {
              const newEvents = events.filter((e) => e.id !== item.id);
              setEvents(newEvents);
              const newToDos = toDos.filter((e) => e.id !== item.id);
              setToDos(newToDos);
              deleteEvent(item);
            }} />
          </List.Item>
        )}
      />
    </div>
    <InfoModal
      open={infoModal}
      event={event}
      close={() => {
        form.resetFields();
        setInfoModal(false);
      }}
      update={() => {
        setInfoModal(false);
        setEventModal(true);
        form.setFieldsValue({"title": event.title, "content": event.content, "startDate": event.start, "endDate": event.end, "fullDay": event.allDay, "color": event.color, "toDo": event.toDo});
        if(event.allDay === false)
          form.setFieldsValue({"startTime": event.start, "endTime": event.end});
      }}
    />
    <EventModal
      form={form}
      open={eventModal}
      type={"update"}
      defaultValue={event}
      close={() => {
        form.resetFields();
        setEventModal(false);
      }}
    />
  </>
  )

}

export default ToDOList;