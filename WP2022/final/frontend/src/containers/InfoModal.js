import { Modal, Button } from "antd";
import { useCalendar } from "./hook/useCalendar";

const InfoModal = ({ open, event, close, update }) => {
  const { events, setEvents, deleteEvent } = useCalendar();
  let start, end;
  if(open){
    if(event.allDay){
      start = event.start.format("YYYY/MM/DD");
      end = event.end.format("YYYY/MM/DD");
    }else{
      start = event.start.format("YYYY/MM/DD HH:mm:ss");
      end = event.end.format("YYYY/MM/DD HH:mm:ss");
    }
    return (
      <Modal
        open={open}
        okText="Update"
        cancelText="Close"
        onCancel={() => close()}
        onOk={() => update()}
        width="25vw"
        footer={[
          <Button key="update" type="primary" onClick={update}>Update</Button>,
          <Button key="delete" type="primary" style={{ background: "red"}}
            onClick={()=> {
              const newEvents = events.filter((e) => e.id !== event.id);
              setEvents(newEvents);
              deleteEvent(event);
              close();
            }}
          >
            Delete
          </Button>
        ]}
      >
        <h1>{event.title}</h1>
        <b style={{fontSize: 16}}>Start</b>
        <p style={{fontSize: 16}}>{start}</p>
        <b style={{fontSize: 16}}>End</b>
        <p style={{fontSize: 16}}>{end}</p>
        <b style={{fontSize: 16}}>Content</b>
        <p style={{fontSize: 16}}>{event.content || "None"}</p>
        <b style={{fontSize: 16}}>Put to TODO List?</b>
        <p style={{fontSize: 16}}>{(event.toDo && "Yes") || "No"}</p>

      </Modal>
    )
  } else return null;
}

export default InfoModal;