import {Router} from 'express';
import {checkPromise} from './routerHelperFunctions.js';
import { tasksDal } from '../dal.js';

const tasksRouter = Router();

tasksRouter.post('/', (req,res)=>{
    const {userId, listId, taskName} = req.body;
    checkPromise(tasksDal.createTask({listId: req.body.listId, userId: req.body.userId, taskName: req.body.taskName}), res);
})

tasksRouter.get('/:userId/:listId', (req,res)=>{
    checkPromise(tasksDal.getAllTasks({userId:req.params.userId, listId: req.params.listId}),res);
});

tasksRouter.get('/:userId/:listId/:taskId', (req,res)=>{
    checkPromise(tasksDal.getTask({taskId:req.params.taskId,userId:req.params.userId, listId: req.params.listId}),res);
});

tasksRouter.patch('/:userId/:listId/:taskId', (req,res)=>{
    const{taskName,taskStatus} = req.body;
    console.log(taskStatus);
    if (taskName!=null || taskStatus!=null){
        checkPromise(tasksDal.updateTask({taskId:req.params.taskId, userId: req.params.userId, listId: req.params.listId, payload:{taskName:taskName, taskStatus:taskStatus}}),res);
    }
    else{
        console.log('Nothing to update');
    }
});

tasksRouter.delete('/:userId/:listId/:taskId', (req,res)=>{
    checkPromise(tasksDal.deleteTask({taskId:req.params.taskId, userId: req.params.userId, listId: req.params.listId}),res);
});
tasksRouter.delete('/:userId/:listId',(req,res)=>{
    checkPromise(tasksDal.deleteAllTasks({listId: req.params.listId,userId: req.params.userId}),res)
})
export default tasksRouter;