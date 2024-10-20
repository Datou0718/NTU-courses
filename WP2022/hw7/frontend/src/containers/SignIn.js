import AppTitle from '../components/Title'
import Login from '../components/Login'
import {useChat} from './hooks/useChat'

const SignIn = ({me}) => {
    const {setMe, setSignedIn, displayStatus} = useChat()

    const handleLogin = (name) => {
        if(!name)
            displayStatus({
                type: "error",
                msg: "missing user name",
            })
        else
            setSignedIn(true)
    }
    return(
        <>
            <AppTitle/>
            <Login me={me} setName={setMe} onLogin={handleLogin} />
        </>
    )
}

export default SignIn