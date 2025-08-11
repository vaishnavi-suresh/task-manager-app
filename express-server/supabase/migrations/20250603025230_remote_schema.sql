

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE SCHEMA IF NOT EXISTS "custom";


ALTER SCHEMA "custom" OWNER TO "postgres";


CREATE SCHEMA IF NOT EXISTS "drizzle";


ALTER SCHEMA "drizzle" OWNER TO "postgres";


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";





SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "custom"."lists" (
    "user_id" character varying NOT NULL,
    "list_id" integer NOT NULL,
    "list_name" "text" NOT NULL
);


ALTER TABLE "custom"."lists" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "custom"."lists_list_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "custom"."lists_list_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "custom"."lists_list_id_seq" OWNED BY "custom"."lists"."list_id";



CREATE TABLE IF NOT EXISTS "custom"."tasks" (
    "user_id" character varying NOT NULL,
    "list_id" integer NOT NULL,
    "task_id" integer NOT NULL,
    "task_name" "text" NOT NULL
);


ALTER TABLE "custom"."tasks" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "custom"."tasks_task_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "custom"."tasks_task_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "custom"."tasks_task_id_seq" OWNED BY "custom"."tasks"."task_id";



CREATE TABLE IF NOT EXISTS "custom"."users" (
    "user_id" character varying NOT NULL,
    "email" character varying NOT NULL,
    "name" "text" NOT NULL
);


ALTER TABLE "custom"."users" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "drizzle"."__drizzle_migrations" (
    "id" integer NOT NULL,
    "hash" "text" NOT NULL,
    "created_at" bigint
);


ALTER TABLE "drizzle"."__drizzle_migrations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "drizzle"."__drizzle_migrations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "drizzle"."__drizzle_migrations_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "drizzle"."__drizzle_migrations_id_seq" OWNED BY "drizzle"."__drizzle_migrations"."id";



ALTER TABLE ONLY "custom"."lists" ALTER COLUMN "list_id" SET DEFAULT "nextval"('"custom"."lists_list_id_seq"'::"regclass");



ALTER TABLE ONLY "custom"."tasks" ALTER COLUMN "task_id" SET DEFAULT "nextval"('"custom"."tasks_task_id_seq"'::"regclass");



ALTER TABLE ONLY "drizzle"."__drizzle_migrations" ALTER COLUMN "id" SET DEFAULT "nextval"('"drizzle"."__drizzle_migrations_id_seq"'::"regclass");



ALTER TABLE ONLY "custom"."lists"
    ADD CONSTRAINT "listsPk" PRIMARY KEY ("user_id", "list_id");



ALTER TABLE ONLY "custom"."tasks"
    ADD CONSTRAINT "tasksPk" PRIMARY KEY ("user_id", "list_id", "task_id");



ALTER TABLE ONLY "custom"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "drizzle"."__drizzle_migrations"
    ADD CONSTRAINT "__drizzle_migrations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "custom"."lists"
    ADD CONSTRAINT "listsFk" FOREIGN KEY ("user_id") REFERENCES "custom"."users"("user_id");



ALTER TABLE ONLY "custom"."tasks"
    ADD CONSTRAINT "tasksFk" FOREIGN KEY ("user_id", "list_id") REFERENCES "custom"."lists"("user_id", "list_id");





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";
































































































































































































ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
