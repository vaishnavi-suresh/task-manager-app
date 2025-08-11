import {Router} from 'express';
import {usersDal} from '../dal.js';
import {checkPromise} from './routerHelperFunctions.js';

const usersRouter = Router();



usersRouter.post('/', (req,res)=>{
    const {userId,name,email} = req.body;
    usersDal.createUser({userId:userId, email:email,name:name});
    res.status(201).send(req.body)
});

usersRouter.get('/:userId',async(req,res)=>{
    checkPromise(usersDal.getUser(req.params.userId),res);

});

usersRouter.get('/:userId/email',(req,res)=>{
    checkPromise(usersDal.getUserEmail(req.params.userId),res);
});

usersRouter.get('/:userId/name',(req,res)=>{
    checkPromise(usersDal.getUserName(req.params.userId),res);
})

usersRouter.patch('/:userId',(req,res)=>{
    const {name,email} = req.body;
    const payload = Object.fromEntries({name,email}).filter(([key,value])=>value!=null);
    checkPromise(usersDal.updateUser(req.params.userId,payload),res);
})

//update email and name not necessary

usersRouter.delete('/:userId',(req,res)=>{
    checkPromise(usersDal.deleteUser(req.params.userId),res);
})

export default usersRouter;