import {createContext, useContext,useState, useEffect} from "react";
import {message} from 'antd'

const LOCALSTORAGE_KEY = 'save-me'
const savedMe = localStorage.getItem(LOCALSTORAGE_KEY)

const ChatContext = createContext({
    status: {},
    me: '',
    signedIn: false,
    messages: [],
    sendMessage: () => {},
    clearMessages: () => {}
})

const client = new WebSocket('ws://localhost:4000')

const ChatProvider = (props) => {
    const [messages, setMessages] = useState([]);
    const [me, setMe] = useState(savedMe || '');
    const [signedIn, setSignedIn] = useState(false);
    const [status, setStatus] = useState({});

    client.onmessage = (byteString) => {
        const {data} = byteString
        const [task, payload] = JSON.parse(data);
        switch(task){
            case 'init':{
                setMessages(payload)
                break
            }
            case 'output': {
                setMessages(() => [...messages, ...payload]) //原本的messages + 新的payload, 因為init的時候會有一堆payload, 所以是...payload
                break
            }
            case 'status':{
                setStatus(payload)
                break
            }
            case 'cleared': {
                setMessages([])
                break
            }
            default:break
        }
    }

    const sendMessage = (payload) => {
        sendData(["input", payload]);
    }

    const sendData = async(data) => { //async:等到都做完才會做下面,同步
        await client.send(JSON.stringify(data));
    }

    const clearMessages = () => {
        sendData(["clear"])
    }
    
    const displayStatus = (s) => {
        if(s.msg){
            const{type, msg} = s;
            const content = {
                content: msg, duration: 0.5
            }
            switch(type){
                case 'success':
                message.success(content) 
                break
                case 'error':
                default:
                    message.error(content)
                    break
            }
        }
    }

    useEffect(() => {
        if(signedIn)
            localStorage.setItem(LOCALSTORAGE_KEY, me)
    }, [signedIn])

    return(
        <ChatContext.Provider
            value={{
                status, me, signedIn, messages, setMe, setSignedIn, sendMessage, clearMessages, displayStatus
            }}
            {...props}
        />
    );
};
const useChat = () => useContext(ChatContext);
export {ChatProvider, useChat}