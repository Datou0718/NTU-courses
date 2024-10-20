import { Modal} from "antd";
import { useCalendar } from "./hook/useCalendar";
import {useState} from "react";
import "../css/SignUp.css"

const SignUp = ({ open, close }) => {
  const { newUser, displayStatus } = useCalendar();
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [nameFlag, setNameFlag] = useState("hidden");
  const [passFlag, setPassFlag] = useState("hidden");
  const [confirmFlag, setConfirmFlag] = useState("hidden");

  const handleSignUp = async () => {
    if(name === "" || password === "" || confirm === ""){
      if(name === "")
        setNameFlag("initial");
      if(password === "")
        setPassFlag("initial");
      if(confirm === "")
        setConfirmFlag("initial");
    }
    else if(password !== confirm){
      displayStatus("error", "inconsistency between passwords");
      setPassword("");
      setConfirm("");
    }
    else if(await newUser(name, password) === true){
      handleClose();
    }
  }

  const handleClose = () => {
    setName("");
    setPassword("");
    setConfirm("");
    setNameFlag("hidden");
    setPassFlag("hidden");
    setConfirmFlag("hidden");
    close();
  }

  if(open)
    return (
      <Modal 
        open={open}
        okText="Submit"
        cancelText="close"
        onOk={handleSignUp}
        onCancel={handleClose}
        style={{top: "25%"}}
      >
        <div className="box">
          <p style={{visibility: "hidden"}}>a</p>
          <h1>SIGN UP</h1>
          <p style={{visibility: "hidden"}}>a</p>
          <div className='input_area'>
            <input type='text' value={name} placeholder='username' onChange={(e) => {
              setName(e.target.value);
              if(e.target.value === "")
                setNameFlag("initial")
              else
                setNameFlag("hidden")}}></input>
            <p style={{color: "red", visibility: nameFlag}}>Error: username can't be empty!</p>
          </div>
          <div className='input_area'>
            <input type='password' value={password} placeholder='password' onChange={(e) => {
              setPassword(e.target.value);
              if(e.target.value === "")
                setPassFlag("initial")
              else
                setPassFlag("hidden")}}></input>
            <p style={{color: "red", visibility: passFlag}}>Error: password can't be empty!</p>
          </div>
          <div className='input_area'>
            <input type='password' value={confirm} placeholder='confirm password' onChange={(e) => {
              setConfirm(e.target.value);
              if(e.target.value === "")
                setConfirmFlag("initial")
              else
                setConfirmFlag("hidden")}}
                onKeyDown={(e) => {
                  if(e.keyCode === 13)
                    handleSignUp()
                }} required></input>
            <p style={{color: "red", visibility: confirmFlag}}>Error: password can't be empty!</p>
          </div>
        </div>
      </Modal>
    );
  else return null;
}

export default SignUp;