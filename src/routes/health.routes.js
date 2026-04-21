import { Router } from 'express';
import { pool } from '../../config/db.js';

const router = Router();

// Health check DB real verificando conexión a PostgreSQL
router.get('/db-check', async (req, res, next) => {
    try {
        const result = await pool.query('SELECT NOW()');
        console.log(result);
        res.json({
            ok: true,
            mensaje: 'Servidor activo y DB conectada correctamente',
            tiempo: result.rows[0].now
        });
    } catch (error) {
        next(error);
    }
});

export default router;
