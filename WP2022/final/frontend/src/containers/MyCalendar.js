import React, { useState } from 'react'
import FullCalendar from '@fullcalendar/react'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from "@fullcalendar/interaction" // needed for dayClick

import { Form } from "antd";
import dayjs from 'dayjs'

import EventModal from './EventModal'
import InfoModal from './InfoModal'
import { useCalendar } from './hook/useCalendar'

const MyCalendar = () => {

  const { events, getEventInfo } = useCalendar();
  const [event, setEvent] = useState({});
  const [eventModal, setEventModal] = useState(false);
  const [infoModal, setInfoModal] = useState(false);
  const [type, setType] = useState('');
  const [form] = Form.useForm();

  return (
    <div className='calendarContainer'>
      <FullCalendar
        headerToolbar={{
          start: 'dayGridMonth,timeGridWeek,timeGridDay',
          center: 'title'
        }}
        events={events}
        plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
        height='85vh'
        eventTimeFormat={{
          hour:'numeric',
          minute:'2-digit',
          meridiem:false,
        }}
        eventClick={async (arg) => {
          let info = await getEventInfo(arg.event.id);
          setInfoModal(true);
          info.start = dayjs(info.start);
          info.end = (info.allDay)? dayjs(info.end).subtract(1, "day"): dayjs(info.end);
          setEvent(info);
        }}
        dateClick={(arg) => {
          setEventModal(true);
          setEvent({allDay: true, toDo: true});
          setType("new");
          form.setFieldsValue({"startDate": dayjs(arg.dateStr),"endDate": dayjs(arg.dateStr)})
        }}
      />
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
          setType("update");
          form.setFieldsValue({"title": event.title, "content": event.content, "startDate": event.start, "endDate": event.end, "fullDay": event.allDay, "color": event.color, "toDo": event.toDo});
          if(event.allDay === false)
            form.setFieldsValue({"startTime": event.start, "endTime": event.end});
        }}
      />
      <EventModal
        form={form}
        open={eventModal}
        type={type}
        defaultValue={event}
        close={() => {
          form.resetFields();
          setEventModal(false);
        }}
      />
    </div>
  )
}

export default MyCalendar