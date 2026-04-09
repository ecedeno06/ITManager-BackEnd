import express from 'express'
import userRoutes from './routes/user.routes.js'
import authRoutes from './routes/auth.js'

const app = express()

app.use(express.json())
app.use('auth',auth.userRoutes)
app.use('/usuarios', userRoutes)

export default app