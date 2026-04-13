
import app from './src/app.js'

const PORT = process.env.PORT || 8080;

//app.listen(3000, () => {
 console.log('Server running on http://localhost:3000')
//});
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

app.get ('/', (req,res) => {
  res.send ('Api Funcionando...');
});

app.get('/db-check', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({ status: 'ok', time: result.rows[0] });
  } catch (error) {
    res.status(500).json({ status: 'error', message: error.message, stack: error.stack });
  }
});


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