import './styles.css';
import {useState} from "react";
import XButton from './x.png';

function App() {
  const [todoList, SetTodoList] = useState([]);
  const [ActiveState, SetActiveState] = useState(1);
  const [CompleteState, SetCompleteState] = useState(1);
  const [taskCnt, SetTaskCnt] = useState(0);

  const addTask = (event) => {
    if(event.code === "Enter" && event.target.value !== ""){
      const newTask = {
        name: event.target.value,
        id: todoList.length === 0? 1 : todoList[todoList.length - 1].id + 1,
        completed: false,
      };
      SetTodoList([...todoList, newTask]);
      SetTaskCnt(taskCnt + 1);
      event.target.value = "";
    }
  }

  const deleteTask = (Task) => {
    if(!Task.completed){
      SetTaskCnt(taskCnt - 1);
    }
    SetTodoList(todoList.filter((task) => task.id !== Task.id));
  }

  const completeTask = (task) => {
    task.completed = task.completed? false : true;
    SetTaskCnt(task.completed? taskCnt-1 : taskCnt+1);
  }

  const show_all = () => {
    SetActiveState(1);
    SetCompleteState(1);
  }

  const show_active = () => {
    SetActiveState(1);
    SetCompleteState(0);
  }

  const show_completed = () => {
    SetActiveState(0);
    SetCompleteState(1);
  }

  const clean = () => {
    SetTodoList(todoList.filter((task) => task.completed === false));
  }

  return (
    <div className='todo-app__root'>
      <header className='todo-app__header'>
        <h1 className='todo-app__title'>todos</h1>
      </header>
      <section className='todo-app__main'>
        <input className='todo-app__input' placeholder='What needs to be done?' onKeyPress={(event) => addTask(event)}></input>
        <ul className='todo-app__list' id='todo-list'>
          {todoList.map((task) => {
            return(
              <li className="todo-app__item" key={task.id} 
              style = {{display: (task.completed? CompleteState : ActiveState)? '' : 'none'}}>
                <div className='todo-app__checkbox'>
                  <input type="checkbox" id={task.id} onClick={() => completeTask(task)}></input>
                  <label htmlFor={task.id}></label>
                </div>
                <h1 style = {task.completed? {textDecoration: 'line-through', opacity: '0.5'} : {}} className='todo-app__item-detail'>{task.name}</h1>
                <img src={XButton} alt="delete task" className='todo-app__item-x' onClick={ () => deleteTask(task)}></img>
              </li>
            )
          })}
        </ul>
      </section>
      <footer style = {todoList.length !== 0? {} : {visibility: 'hidden'}} className='todo-app__footer' id='todo-footer'>
        <div className='todo-app__total'>{taskCnt} left</div>
        <ul className='todo-app__view-buttons'>
          <button onClick={() => show_all()}>All</button>
          <button onClick={() => show_active()}>Active</button>
          <button onClick={() => show_completed()}>Completed</button>
        </ul>
        <div className='todo-app__clean'>
          <button style = {todoList.length - taskCnt > 0? {} : {visibility: 'hidden'}} onClick={() => clean()}>Clear completed</button>
        </div>
      </footer>
    </div>
  );
}

export default App;
