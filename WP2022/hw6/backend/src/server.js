import dotenv from 'dotenv-defaults';
import db from './db'
import routes from './routes/index';
import cors from 'cors';
import express from 'express';
import bodyParser from 'body-parser';
import path from "path"
const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use('/',routes);
if(process.env.NODE_ENV === "production"){
    const __dirname = path.resolve();
    app.use(express.static(path.join(__dirname, "../frontend", "build")))
    app.get("/*", function(req, res){
        res.sendFile(path.join(__dirname, "../frontend", "build", "index.html"))
    })
}
dotenv.config();
db.connect();
const port = process.env.PORT || 4000
app.listen(port, () => {
    console.log(`Server is up on port ${port}.`)
})
