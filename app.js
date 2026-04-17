import express from 'express'
import userRoutes from './routes/user.routes.js'

const app = express()

app.use(express.json())
app.use('/usuarios', userRoutes)

export default app