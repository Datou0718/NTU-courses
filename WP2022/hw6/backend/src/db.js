import mongoose from 'mongoose'
import dotenv from 'dotenv-defaults';
export default{
    connect: () => {
        dotenv.config()
        mongoose.connect(
            process.env.MONGO_URL, {
                useNewUrlParser: true,
                useUnifiedTopology: true
            }
        ).then((res) => console.log(`db connect succeed!`));
    }
}

