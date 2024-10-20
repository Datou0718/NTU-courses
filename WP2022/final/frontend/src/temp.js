import { Modal, Form, Input, DatePicker, Button, Switch, TimePicker, message } from "antd";
import { v4 as uuidv4 } from 'uuid'

import { useCalendar } from './hook/useCalendar';
import axios from '../axios.js'

const EventModal = ({form, open, type, defaultValue, close}) => {
  const { me, events, setEvents, newEvent, updateEvent } = useCalendar();

  const updateEvents = async (update) => {
    let start, end;
    if(update.startFullDay === false)
      start = update.start.format("YYYY-MM-DDT") + update.startTime.format("HH:mm:ss");
    else
      start = update.start.format("YYYY-MM-DDT") + "00:00:00";
    
    if(update.endFullDay === false)
      end = update.end.format("YYYY-MM-DDT") + update.endTime.format("HH:mm:ss");
    else
      end = update.end.format("YYYY-MM-DDT") + "23:59:00";

    const event = { name: me, title: update.title, content: update.content, start: start, end: end };
    if(type === "new"){
      event.id = uuidv4();
      setEvents([...events, event]);
      newEvent(event);
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
    }
  }

  return (
    <Modal 
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
      onCancel={close}
      onOk={() => {form.validateFields()
        .then((values) => {
          form.resetFields();
          updateEvents(values);
          close();
        })
        .catch((e) => {window.alert(e)});
      }}
    >
    <Form form={form} layout='vertical' name='form_in_modal'>
      <Form.Item
        name="start"
        label="Start"
        rules={[
          {
            required: true,
            message: 'Error: Please choose the date of the event to start!',
          },
        ]}
      >
        <DatePicker format = "YYYY/MM/DD"/>
      </Form.Item>
      <Form.Item name="startFullDay" label="Full Day" valuePropName="checked">
        <Switch defaultChecked />
      </Form.Item>
      <Form.Item dependencies={["startFullDay"]}>
        {() => {
          const full = form.getFieldValue("startFullDay");
          if(full === false){
            return (
              <Form.Item name="startTime" label="Time">
                <TimePicker />
              </Form.Item>
            )
          }else
            return null
        }}
      </Form.Item>
      <Form.Item
        name="end"
        label="End"
        rules={[
          {
            required: true,
            message: 'Error: Please choose the date of the event to end!',
          },
        ]}
      >
        <DatePicker
          format = "YYYY/MM/DD"
        />
      </Form.Item>
      <Form.Item name="endFullDay" label="Full Day" valuePropName="checked">
        <Switch defaultChecked />
      </Form.Item>
      <Form.Item dependencies={["endFullDay"]}>
        {() => {
          const full = form.getFieldValue("endFullDay");
          if(full === false){
            return (
              <Form.Item name="endTime" label="Time">
                <TimePicker />
              </Form.Item>
            )
          }else
            return null
        }}
      </Form.Item>
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
    </Form>
  </Modal>
  )
}

export default EventModal;