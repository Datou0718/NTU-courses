import express from 'express';
import cors from 'cors';

import mongo from './mongo.js'
import routes from './routes/index.js'; 
import path from "path"
const app = express();

// init middleware
app.use(cors());
app.use(express.json());

// define routes
app.use('/', routes);

// deploy
if(process.env.NODE_ENV === "production"){
    const __dirname = path.resolve();
    app.use(express.static(path.join(__dirname, "../frontend", "build")))
    app.get("/*", function(req, res){
        res.sendFile(path.join(__dirname, "../frontend", "build", "index.html"))
    })
}

// define server
const port = process.env.PORT || 4000;
app.listen(port, () => {console.log(`Server is up on port ${port}.`)});

mongo.connect();