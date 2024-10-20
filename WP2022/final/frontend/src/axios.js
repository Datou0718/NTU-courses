import axios from 'axios'

const API_ROOT = "http://localhost:4000"
const instance = process.env.NODE_ENV === "production"?
axios.create({baseURL: "/"}) : axios.create({ baseURL: API_ROOT })

export default instance;