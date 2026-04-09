import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import pool from './config/db.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// Health check endpoint
app.get('/api/health', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.status(200).json({
      status: 'UP',
      database: 'CONNECTED',
      time: result.rows[0].now
    });
  } catch (err) {
    res.status(500).json({
      status: 'DOWN',
      database: 'DISCONNECTED',
      error: err.message
    });
  }
});

// Basic route for IT Assets (to be expanded)
app.get('/api/assets', (req, res) => {
  res.json({ message: 'IT Assets API is running' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
