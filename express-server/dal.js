import { and, eq } from 'drizzle-orm';
import {db} from './connection.js';
import {users,lists,tasks} from '../build/schema.js';

export const usersDal = {
    async createUser({userId, email,name}){
        await db.insert(users).values({userId:userId, email: email, name: name})
    },
    async updateUser(userId, payload){
        return await db.update(users).set(payload).where(eq(users.userId, userId))
    },
    async updateUserName(userId, name){
        return await db.update(users).set({name:name}).where(eq(users.userId, userId))
    },
    async updateUserEmail(userId, email){
        return await db.update(users).set({email:email}).where(eq(users.userId, userId))
    },
    async deleteUser(userId){
        return await db.delete(users).where(eq(users.userId,userId))
    },
    async getUser(userId){
        return await db.select().from(users).where(eq(users.userId, userId))
    },
    async getUserName(userId){
        return await db.select({name:users.name}).from(users).where(eq(users.userId, userId))
    },
    async getUserEmail(userId){
        return await db.select({email:users.email}).from(users).where(eq(users.userId, userId))
    }
}

export const listDal = {
    async createList({userId, listName}){
        return await db.insert(lists).values({userId: userId,  listName: listName});
    },
    async updateList({userId, listId, payload}){
        return await db.update(lists).set(payload).where(and(eq(lists.userId,userId),eq(lists.listId,listId)));
    },
    async deleteList({userId,listId}){
        return await db.delete(lists).where(and(eq(lists.userId,userId),eq(lists.listId,listId)));
    },
    async getAllLists({userId}){
        console.log(userId);
        return await db.select().from(lists).where(eq(lists.userId,userId));
    },
    async getList({userId,listId}){
        return await db.select().from(lists).where(and(eq(lists.userId,userId),eq(lists.listId,listId)));
    },
    async getListName({userId,listId}){
        return await db.select({listName:lists.listName}).from(lists).where(and(eq(lists.userId,userId),eq(lists.listId,listId)));
    }
}

export const tasksDal={
    async createTask({listId,userId,taskName}){
        return await db.insert(tasks).values({listId:listId,userId:userId,taskName:taskName, taskStatus: false});
    },
    async updateTask({taskId,listId,userId,payload}){
        return await db.update(tasks).set(payload).where(and(eq(tasks.taskId, taskId), eq(tasks.listId,listId),eq(tasks.userId,userId)));
    },
    async deleteTask ({taskId,listId,userId}){
        return await db.delete(tasks).where(and(eq(tasks.taskId, taskId), eq(tasks.listId,listId),eq(tasks.userId,userId)));
    },
    async deleteAllTasks({listId,userId}){
    return await db.delete(tasks).where(and(eq(tasks.listId,listId),eq(tasks.userId,userId)));
    },
    async getAllTasks({userId,listId}){
        return await db.select().from(tasks).where(and(eq(tasks.userId,userId),eq(tasks.listId,listId)));
    },
    async getTask({taskId,listId,userId}){
        return await db.select().from(tasks).where(and(eq(tasks.taskId, taskId), eq(tasks.listId,listId),eq(tasks.userId,userId)));
    },
}