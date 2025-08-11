import express from 'express';
import cors from 'cors';
import usersRouter from './routes/users.js';
import listRouter from './routes/lists.js';
import dotenv from 'dotenv';
import tasksRouter from './routes/tasks.js';


dotenv.config({path: '../.env'});

const port = process.env.PORT;
const app = express();
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.send('API is working 🚀');
});

app.use('/users',usersRouter);
app.use('/lists',listRouter);
app.use('/tasks', tasksRouter)

app.listen(port,()=>{
    console.log(`Server is running on ${port}`);
})
