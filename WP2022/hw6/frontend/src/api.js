import axios from 'axios';

const instance = process.env.NODE_ENV === "production"?
axios.create({baseURL: "/"}) : axios.create({baseURL: "http://localhost:4000/"});

export default instance;


// instance.get('/hi').then((data) => console.log(data));
