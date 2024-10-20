import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import React from "react";
import "../css/LogIn.css"
import { useCalendar } from './hook/useCalendar'
import SignUp from './SignUp';

const LogIn = () => {
  const { setMe, setLogIn, checkUser } = useCalendar();
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [sign, setSign] = useState(false);
  const [nameFlag, setNameFlag] = useState("hidden");
  const [passFlag, setPassFlag] = useState("hidden");
  const navigate = useNavigate();

  const handleLogin = async () => {
    if(name === "" || password === ""){
      if(name === ""){
        setNameFlag("initial");
      }
      if(password === "")
        setPassFlag("initial");
    }
    else if(await checkUser(name, password)){
      localStorage.setItem('logIn', 'true');
      localStorage.setItem('user', name);
      localStorage.setItem('navigate', 'calendar');
      setMe(name);
      setLogIn('true');
      navigate('/calendar');
    }else{
      setName("");
      setPassword("");
    }
  
  }

  return (
    <div className='container'>
      <SignUp open={sign} close={() => setSign(false)}/>
      <div className='cover'>
        <h1>LOGIN</h1>
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
              setPassFlag("hidden")}}
            onKeyDown={(e) => {
              if(e.keyCode === 13)
                handleLogin()
            }}></input>
          <p style={{color: "red", visibility: passFlag}}>Error: password can't be empty!</p>
        </div>
        <div className='login_btn' onClick={handleLogin} >LOGIN</div>
        <p style={{cursor: "pointer"}} onClick={setSign}>not a member? click here!</p>
      </div>
    </div>
  );
}

export default LogIn;