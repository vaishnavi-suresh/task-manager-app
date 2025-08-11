CREATE SCHEMA "custom";
--> statement-breakpoint
CREATE TABLE "custom"."lists" (
	"user_id" varchar NOT NULL,
	"list_id" serial PRIMARY KEY NOT NULL,
	"list_name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "custom"."tasks" (
	"user_id" varchar NOT NULL,
	"list_id" integer NOT NULL,
	"task_id" serial PRIMARY KEY NOT NULL,
	"task_name" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "custom"."users" (
	"user_id" varchar PRIMARY KEY NOT NULL,
	"email" varchar NOT NULL,
	"name" text NOT NULL
);
--> statement-breakpoint
ALTER TABLE "custom"."lists" ADD CONSTRAINT "lists_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "custom"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "custom"."tasks" ADD CONSTRAINT "tasks_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "custom"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "custom"."tasks" ADD CONSTRAINT "tasks_list_id_lists_list_id_fk" FOREIGN KEY ("list_id") REFERENCES "custom"."lists"("list_id") ON DELETE no action ON UPDATE no action;