import { Modal, Form, Input, DatePicker, Switch, TimePicker, Radio, Tag } from "antd";
import { v4 as uuidv4 } from 'uuid'
import { useState, useEffect } from "react";
import "../css/EventModal.css"
import { useCalendar } from './hook/useCalendar';

const EventModal = ({form, open, type, defaultValue, close}) => {
  const { me, events, setEvents, toDos, setToDos, newEvent, updateEvent } = useCalendar();
  const [allDay, setAllDay] = useState(defaultValue.allDay);
  const [toDo, setToDo] = useState(defaultValue.toDo);


  useEffect(() => {
    setAllDay(defaultValue.allDay);
    setToDo(defaultValue.toDo);
  }, [defaultValue]);

  const updateEvents = async (update) => {
    let start, end;
    if(update.fullDay === false){
      start = update.startDate.format("YYYY-MM-DDT") + update.startTime.format("HH:mm:ss");
      end = update.endDate.format("YYYY-MM-DDT") + update.endTime.format("HH:mm:ss");
    }else{
      start = update.startDate.format("YYYY-MM-DD");
      let fakeEnd = update.endDate;
      fakeEnd.$D += 1;
      end = fakeEnd.format("YYYY-MM-DD");
    }

    const event = { name: me, title: update.title, content: update.content, start: start, end: end, allDay: allDay, color: update.color, toDo: toDo, finish: false };
    if(type === "new"){
      event.id = uuidv4();
      setEvents([...events, event]);
      newEvent(event);
      if(event.toDo){
        setToDos([...toDos, event].sort((a, b) => {return new Date(a.end) - new Date(b.end)}));
      }
    }else{
      const newEvents = events.map((e) => {
        if(e.id === defaultValue.id){
          event.id = defaultValue.id;
          return event;
        }
        return e;
      })
      setEvents(newEvents);
      updateEvent(event);
      let newToDos;
      if(defaultValue.toDo !== event.toDo && defaultValue.toDo){
        newToDos = toDos.filter((t) => t.id !== defaultValue.id);
      }else if(defaultValue.toDo !== event.toDo && event.toDo){
        newToDos = [...toDos, event];
      }
      setToDos(newToDos.sort((a, b) => {return new Date(a.end) - new Date(b.end)}));
    }
  }

  return (
    <Modal style={{position: 'relative', top: '6%'}}
      open={open}
      title=
      {
        type === "new"
        ? "Create a new event"
        : "Update event info"
      }
      okText=
      {
        type === "new"
        ? "Create"
        : "Update"
      }
      cancelText="Cancel"
      onCancel={() => close()}
      onOk={() => {form.validateFields()
        .then((values) => {
          form.resetFields();
          updateEvents(values);
          close();
        })
      }}
    >
    <Form form={form} layout='vertical' name='form_in_modal'>
      <div style={{width: '100%', display: 'flex', justifyContent: 'space-between'}}>
        <Form.Item name="startDate" label="Start Date" style={{width: '50%'}} rules={[
            {
              required: true,
              message: 'Error: Please choose the date of the event to start!',
            },
          ]}
        >
          <DatePicker format = "YYYY/MM/DD"/>
        </Form.Item>
        <Form.Item name="startTime" label="Start Time" style={{width: '50%'}} hidden={allDay} rules={[
            {
              required: allDay? false: true,
              message: 'Error: Please choose the time of the event to start!',
            },
          ]}
        >
          <TimePicker />
        </Form.Item>
      </div>

      <div style={{width: '100%', display: 'flex', justifyContent: 'space-between'}}>
        <Form.Item name="endDate" label="End Date" style={{width: '50%'}} rules={[
            {
              required: true,
              message: 'Error: Please choose the date of the event to end!',
            },
          ]}
        >
          <DatePicker format = "YYYY/MM/DD"/>
        </Form.Item>
        <Form.Item name="endTime" label="End Time" style={{width: '50%'}} hidden={allDay} rules={[
            {
              required: allDay? false: true,
              message: 'Error: Please choose the time of the event to end!',
            },
          ]}
        >
          <TimePicker />
        </Form.Item>
      </div>
      
      <div style={{width: '100%', display: 'flex', justifyContent: 'space-between'}}>
        <Form.Item name="fullDay" label="Full Day" valuePropName="checked" style={{width: '50%'}}>
          <Switch defaultChecked onClick={(v) => setAllDay(v)} />
        </Form.Item>
        <Form.Item name="toDo" label="Add this event to ToDo List" valuePropName="checked" style={{width: '50%'}}>
          <Switch defaultChecked onClick={(v) => setToDo(v)} />
        </Form.Item>
      </div>
      
      <Form.Item
        name="title"
        label="Title"
        rules={[
          {
            required: true,
            message: 'Error: Please enter the name of the event!',
          },
        ]}
      >
        <Input />
      </Form.Item>

      <Form.Item
        name="content"
        label="Content"
      >
        <Input />
      </Form.Item>
      <Form.Item
        name="color"
        label="Color"
        rules={[
          {
            required: true,
            message: 'Error: Please choose a color!',
          },
        ]}
      >
        <Radio.Group className="color-container">
          <div className="color">
            <Radio value="red"><Tag color="red">red</Tag></Radio>
            <Radio value="orange"><Tag color="orange">orange</Tag></Radio>
          </div>
          <div className="color">
            <Radio value="plum"><Tag color="plum">light purple</Tag></Radio>
            <Radio value="mediumpurple"><Tag color="mediumpurple">purple</Tag></Radio>
          </div>
          <div className="color">
            <Radio value="green"><Tag color="green">green</Tag></Radio>
            <Radio value="darkseagreen"><Tag color="darkseagreen">light green</Tag></Radio>
          </div>
          <div className="color">
            <Radio value="lightpink"><Tag color="lightpink">pink</Tag></Radio>
            <Radio value="skyblue"><Tag color="skyblue">sky blue</Tag></Radio>
          </div>
        </Radio.Group>
      </Form.Item>

    </Form>
  </Modal>
  )
}

export default EventModal;