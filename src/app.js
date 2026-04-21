import express from 'express';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js';
import userRoutes from './routes/user.routes.js';
import healthRoutes from './routes/health.routes.js';
import { errorHandler } from './middlewares/error.middleware.js';

const app = express();

// Middlewares globales
app.use(cors());
app.use(express.json());

// Ruta principal (útil para revisar si la API está viva en producción/Render)
app.get('/', (req, res) => {
    res.send('API Funcionando...');
});

// Rutas Base / Sistema
app.use('/', healthRoutes);

// Rutas API (usando prefijo /api recomendado como "Senior")
app.use('/api/auth', authRoutes);
app.use('/api/usuarios', userRoutes);

// Ruta no encontrada (404)
app.use((req, res) => {
    res.status(404).json({
        ok: false,
        mensaje: 'Ruta no encontrada'
    });
});

// Middleware global de errores (siempre va al final)
app.use(errorHandler);

export default app;