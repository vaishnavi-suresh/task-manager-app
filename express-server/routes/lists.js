import {Router} from 'express';
import {listDal} from '../dal.js';
import {checkPromise} from './routerHelperFunctions.js';

const listRouter = Router();

listRouter.post('/',(req,res)=>{
    const {userId, listName} = req.body;
    checkPromise(listDal.createList({listName: listName, userId: userId}),res);
});

listRouter.get('/:userId', (req,res)=>{
    checkPromise(listDal.getAllLists({userId:req.params.userId}), res);
});

listRouter.get('/:userId/:listId', (req,res)=>{
    checkPromise(listDal.getList({userId: req.params.userId, listId: req.params.listId}), res);
});

listRouter.get('/:userId/:listId', (req,res)=>{
    checkPromise(listDal.getListName({userId: req.params.userId, listId: req.params.userId}),res);
});

listRouter.patch('/:userId/:listId', (req,res)=>{
    const{listName} = req.body;
    if (listName != null){
        checkPromise(listDal.updateList({userId: req.params.userId, listId: req.params.listId}),res);

    }
    else{
        console.log('Nothing to Update');
    }
});

listRouter.delete('/:userId/:listId', (req,res)=>{
    checkPromise(listDal.deleteList({userId: req.params.userId, listId: req.params.listId}),res);
});

export default listRouter;