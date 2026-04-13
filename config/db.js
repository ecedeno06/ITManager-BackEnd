import { Pool } from 'pg'
import dotenv from 'dotenv'

dotenv.config();

/*
console.log({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER
})
*/

export const pool = new Pool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: {
    rejectUnauthorized: false
  },
  connectionTimeoutMillis: 10000, // 10s para el handshake inicial
  idleTimeoutMillis: 30000,
  max: 10 // Limitar conexiones para no saturar el pooler de Supabase
})

pool.on('error', (err, client) => {
  console.error('❌ Error inesperado en el pool de PostgreSQL:', err);
});

