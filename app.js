import express from 'express'
import userRoutes from './routes/user.routes.js'
import authRoutes from './routes/auth.js'

const app = express()

app.use(express.json())
app.use('auth',auth.userRoutes)
app.use('/usuarios', userRoutes)

app.use((err, req, res, next) => {
    console.error(err)
    res.status(500).json({
      error: err.message || 'Internal Server Error'
    })
  })

export default app