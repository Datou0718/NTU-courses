import { Modal } from "antd";
import { useNavigate } from "react-router-dom";

import { useCalendar } from "../containers/hook/useCalendar";

const LogOutModal = ({ open, close }) => {
  const { setMe, setEvents, setLogIn } = useCalendar();
  const navigate = useNavigate();

  return (
    <Modal
      open={open}
      title="Log Out"
      okText="Log out"
      cancelText="Close"
      onCancel={() => close()}
      onOk={() => {
        navigate('/login');
        setLogIn('false');
        setEvents([]);
        setMe("");
        localStorage.setItem('logIn', 'false');
        localStorage.setItem('user', '');
        close();
      }}
      style={{ position: "absolute", left: "34%", top: "40%" }}
    >
    <p>Are you sure to log out?</p>
    </Modal>
  )
}

export default LogOutModal;