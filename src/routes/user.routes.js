// src/routes/user.routes.js
import express from 'express'
import { createUsuario, getUsuarios } from '../controllers/user.controller.js'

const router = express.Router()

router.post('/crearUsuario', createUsuario)
router.get('/listaUsuarios', getUsuarios)

export default router