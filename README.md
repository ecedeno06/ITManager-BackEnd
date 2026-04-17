# IT Asset Management Backend

Este es el backend para el administrador de activos de IT, construido con Node.js (ESM), Express y PostgreSQL.

## Estructura de Carpetas
- `src/config/db.js`: Configuración de la conexión a PostgreSQL.
- `src/models/schema.sql`: Esquema de la base de datos (Ejecuta esto en tu base de datos Cloud).
- `src/index.js`: Punto de entrada de la API.

## Cómo empezar

1. **Configuración de Variables de Entorno**:
   Copia el archivo `.env.example` a `.env` y completa el `DATABASE_URL` con tus credenciales de PostgreSQL Cloud.

   ```bash
   cp .env.example .env
   ```

2. **Instalación de Dependencias**:
   ```bash
   npm install
   ```

3. **Ejecución**:
   ```bash
   npm start
   ```

4. **Verificación**:
   Accede a `http://localhost:5000/api/health` para comprobar la conexión con la base de datos.
