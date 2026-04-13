

import express from 'express'
import userRoutes from './routes/user.routes.js'
import authRoutes from './routes/auth.routes.js';
import cors from 'cors';

const app = express()

app.use(express.json())
app.use(cors())
app.use('/auth', authRoutes)
app.use('/usuarios', userRoutes)

export default app