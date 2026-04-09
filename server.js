
import app from './src/app.js'

const PORT = process.env.PORT || 8080;

//app.listen(3000, () => {
 console.log('Server running on http://localhost:3000')
//});

app.listen (PORT, () => {
    
})


/*import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
  user: 'postgres.fpyxrczcdknfpagwqnng',
  host: 'aws-0-us-west-2.pooler.supabase.com',
  database: 'postgres',
  password: 'ac1e56cu7hRkTO4V',
  port: 6543,
});

(async () => {
  try {
    const res = await pool.query('SELECT NOW()');
    console.log('✅ BD OK:', res.rows);
  } catch (err) {
    console.error('❌ ERROR REAL:', err);
  }
    
})();

*/