import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { pool } from '../../config/db.js';

export async function login(req, res) {
  try {
    const { email, password } = req.body;

    const result = await pool.query(
      `SELECT * FROM ITManager.users WHERE email = $1`,
      [email]
    );

    const user = result.rows[0];

    if (!user) {
      return res.status(401).json({ message: 'Usuario no existe' });
    }

    const valid = await bcrypt.compare(password, user.password);

    if (!valid) {
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }
/*
    // 🔥 Modelo Multitenant (Empresas)
    const companiesResult = await pool.query(`
      SELECT c.id, c.name, ur.role_id as role
      FROM ITManager.user_companies uc
      JOIN ITManager.companies c ON c.id = uc.company_id
      LEFT JOIN ITManager.user_roles ur ON ur.company_id = c.id AND ur.user_email = uc.user_email
      WHERE uc.user_email = $1
    `, [user.email]);
*/
    const token = jwt.sign(
      { 
        email: user.email,
        rol: ["read","write"]
       },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    res.json({
      token,
      companies: 1
    });

  } catch (error) {
    console.error('ERROR LOGIN:', error);
    res.status(500).json({ error: error.message });
  }
}