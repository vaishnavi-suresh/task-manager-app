import { defineConfig } from "drizzle-kit";
import dotenv from 'dotenv';
dotenv.config({path:"../.env"});
export default defineConfig({
    dialect: 'postgresql',
    schema: './schema.ts',
    out: "./supabase/migrations",
    migrations: {
        prefix: 'supabase'
      },
    dbCredentials:{
      url: process.env.DATABASE_URL!
    }
    },
    
  )