// src/controllers/user.controller.js
import { pool } from '../../config/db.js'

export async function getUsuarios(req, res, next) {
  try {
    const result = await pool.query('SELECT * FROM ITManager.users')
    res.status(200).json(result.rows)
  } catch (e) {
    next(e)
  }
}

export async function createUsuario(req, res, next) {
  const {
    correo,
    nombre,
    apellido,
    contrasena,
    tipoDocumento,
    documentoID,
    fechaNacimiento,
    telefonos
  } = req.body

  try {
    const result = await pool.query(
      `INSERT INTO ITManager.users (
        "email",
        "first_name",
        "last_name",
        "password",
        "document_type",
        "document_id",
        "birth_date",
        phones
      )
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8)
      RETURNING *`,
      [
        correo,
        nombre,
        apellido,
        contrasena,
        tipoDocumento,
        documentoID,
        fechaNacimiento,
        JSON.stringify(telefonos ?? [])
      ]
    )

    res.status(201).json(result.rows[0])
  } catch (e) {
    next(e)
  }
}