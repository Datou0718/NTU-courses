import React from 'react';
import './App.css';
import { Route, Routes, useNavigate, useLocation } from 'react-router-dom';
import { Layout, Menu, Typography, Button } from 'antd';
import { useState,  useEffect } from 'react';

import LogIn from './containers/LogIn';
import MyCalendar from './containers/MyCalendar';
import LogOutModal from './components/LogOutModal';
import ToDOList from './containers/ToDoList';
import Setting from './containers/Setting';
import { useCalendar } from './containers/hook/useCalendar';

const { Header, Sider } = Layout;
const { Title } = Typography;

function App() {
  const { logIn, me, display } = useCalendar();
  const [showLogOut, setShowLogOut] = useState(false);
  const [key, setKey] = useState('');
  const navigate = useNavigate();
  const location = useLocation();
  console.log(location.pathname);
  useEffect(() => {
    if(location.pathname === '/' && logIn === 'true'){
      navigate('/calendar');
      setKey('calendar');
    }else if(location.pathname === '/' && logIn === 'false')
      navigate('/login');
    else if(location.pathname === '/calendar')
      setKey('calendar');
    else if(location.pathname === '/toDoList')
      setKey('toDo');
    else if(location.pathname === '/setting')
      setKey('setting');
  }, [location.pathname]);

  return (
    logIn === 'true'
    ? 
      <Layout>
        <Sider trigger={null} >
          <Header style={{ padding: "0 0" }}>
            <Title level={3} style={{ marginTop: "0.5em", marginLeft: "0.75em", color: "white" }}>{display}</Title>
          </Header>
          <Menu 
            theme="dark"
            mode="inline"
            items={[
              {
                key: 'calendar',
                label: 'Calendar',
              },
              {
                key: 'toDo',
                label: 'To Do List',
              },
              {
                key: 'setting',
                label: 'Setting',
              },
            ]}
            onClick={(m) => {
              localStorage.setItem('navigate', m.key);
              if(m.key === 'calendar')
                navigate('/calendar');
              else if(m.key === 'toDo')
                navigate('/toDoList');
              else if(m.key === 'setting')
                navigate('/setting');
            }}
            selectedKeys={[key]}
          />
          <Button type='text' style={{ color: "white", width: "90%", textAlign: "left" }} onClick={() => setShowLogOut(true)}>Log out</Button>
        </Sider>
        <LogOutModal
          open={showLogOut}
          close={() => setShowLogOut(false)}
        />
        <Routes>
          <Route path="/calendar" element={<MyCalendar />} />
          <Route path="/toDoList" element={<ToDOList />} />
          <Route path="/setting" element={<Setting />} />
          <Route path='/' element={<MyCalendar />} />
        </Routes>
        
      </Layout>
    : 
      <Routes>
        <Route path="/login" element={<LogIn />} />
        <Route path="/" element={<LogIn />} />
      </Routes>
  )
}

export default App