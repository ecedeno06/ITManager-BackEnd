// src/routes/user.routes.js
import express from 'express'
import { createUsuario, getUsuarios } from '../../controllers/user.controller.js'

const router = express.Router()

router.post('/crearUsuarios', createUsuario)
//router.get('/listarUsuarios', getUsuarios)

router.get('/listarUsuarios', (req, res) => {
    console.log('🔥 RUTA GET OK')
    res.send('ok')
  })

export default router