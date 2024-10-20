import { useState } from "react";

import { useCalendar } from "./hook/useCalendar";
import '../css/Setting.css'

const Setting = () => {
  const { me, display, setDisplay, editUser, displayStatus } = useCalendar();
  const [displayName, setDisplayName] = useState(display);
  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [displayFlag, setDisplayFlag] = useState('hidden');
  const [passwordFlag, setPasswordFlag] = useState('hidden');
  const [confirmFlag, setConfirmFlag] = useState('hidden');


  const handleEdit = () => {
    if(displayName === "" || password === "" || confirm === ""){
      if(displayName === "")
        setDisplayFlag("initial");
      if(password === "")
        setPasswordFlag("initial");
      if(confirm === "")
        setConfirmFlag("initial");
    }else{
      if(password !== confirm){
        displayStatus('error', 'inconsistency between passwords');
        setDisplayName(display);
      }else{
        editUser(me, displayName, password);
        setDisplay(displayName);
      }
      setPassword('');
      setConfirm('');
    }
  }

  return (
    <div className="setting-container">
      <div className='setting-cover'>
        <h1 style={{fontSize: '32px'}}>Edit Profile</h1>
        <div className='input_area'>
          <input type='text' value={displayName} placeholder='display name'
            onChange={(e) => {
              setDisplayName(e.target.value);
              if(e.target.value === "")
                setDisplayFlag("initial");
              else
                setDisplayFlag("hidden");
            }}
          ></input>
          <p style={{color: "red", visibility: displayFlag}}>Error: display name can't be empty!</p>
        </div>
        <div className='input_area'>
          <input type='password' value={password} placeholder='password'
            onChange={(e) => {
              setPassword(e.target.value);
              if(e.target.value === "")
                setPasswordFlag("initial");
              else
                setPasswordFlag("hidden");
            }}
          ></input>
          <p style={{color: "red", visibility: passwordFlag}}>Error: password can't be empty!</p>
        </div>
        <div className='input_area'>
          <input type='password' value={confirm} placeholder='enter password again'
            onChange={(e) => {
              setConfirm(e.target.value);
              if(e.target.value === "")
                setConfirmFlag("initial");
              else
                setConfirmFlag("hidden");
            }}
            onKeyDown={(e) => {
              if(e.keyCode === 13)
                handleEdit()
            }}
          ></input>
          <p style={{color: "red", visibility: confirmFlag}}>Error: password can't be empty!</p>
        </div>
        <div className='edit_btn' onClick={handleEdit} >Submit</div>
      </div>
    </div>
  )
}

export default Setting;