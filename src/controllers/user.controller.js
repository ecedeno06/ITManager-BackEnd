// src/controllers/user.controller.js
import { pool } from "../../config/db.js";

export async function getUsuarios(req, res, next) {
  try {
    const result = await pool.query(`
      SELECT u.*, uc.registrado
      FROM ITManager.users u
      LEFT JOIN ITManager.user_companies uc ON u.email = uc.user_email AND uc.is_primary = true
    `);
    res.status(200).json(result.rows);
  } catch (e) {
    console.error('ERROR REAL:', e)
    res.status(502).json({ error: e.message })
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
    telefonos,
  } = req.body;

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
        JSON.stringify(telefonos ?? []),
      ],
    );

    res.status(201).json(result.rows[0]);
  } catch (e) {
    next(e);
  }
}
