import {pgSchema, integer, varchar, text, boolean, pgTable, serial,primaryKey, foreignKey} from "drizzle-orm/pg-core";
import {defineConfig} from "drizzle-kit";

export const toDoSchema = pgSchema('custom');

export const users = toDoSchema.table('users',
    {
        userId: varchar("user_id").primaryKey(),
        email: varchar().notNull(),
        name: text().notNull()
    }
);
export const lists = toDoSchema.table('lists',
    {
        userId: varchar("user_id").notNull(),
        listId: serial("list_id"),
        listName: text("list_name").notNull()
    },(table) => [
        primaryKey({ columns: [table.userId, table.listId], name: 'listsPk' }),
        foreignKey({columns:[table.userId], foreignColumns:[users.userId],name:'listsFk'})
       ]
);
export const tasks = toDoSchema.table('tasks',
    {
        userId: varchar('user_id').notNull(),
        listId: integer("list_id").notNull(),
        taskId: serial("task_id"),
        taskName: text("task_name").notNull(),
        //taskStatus:boolean("task_status").notNull(),
    },(table) => [
        primaryKey({ columns: [table.userId, table.listId,table.taskId] , name:'tasksPk'}),
        foreignKey({
            columns: [table.userId, table.listId],
            foreignColumns: [lists.userId, lists.listId],
            name: "tasksFk"
          })
       ],
       
);




