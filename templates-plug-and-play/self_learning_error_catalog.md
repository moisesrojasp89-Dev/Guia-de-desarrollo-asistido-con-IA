# 📓 Catálogo de Errores y Auto-Aprendizaje Continuo (5-Whys)

> **Propósito:** Registrar cada fallo significativo o regresión resuelta en este proyecto para que ningún modelo de Inteligencia Artificial vuelva a cometer el mismo error en el futuro.  
> **Ubicación recomendada:** `docs/self_learning_error_catalog.md`

---

## 📌 Plantilla para Nuevas Entradas (Copiar y Pegar)

```markdown
### [ERR-00X] [Título Corto y Descriptivo del Error]
- **Fecha:** YYYY-MM-DD
- **Módulo / Archivo afectado:** `src/...`
- **Síntoma Inicial:** ¿Qué vio el usuario o qué fallo reportó la prueba?
- **Análisis de los 5 Porqués:**
  1. ¿Por qué ocurrió el síntoma? -> [Respuesta 1]
  2. ¿Por qué ocurrió [Respuesta 1]? -> [Respuesta 2]
  3. ¿Por qué ocurrió [Respuesta 2]? -> [Respuesta 3]
  4. ¿Por qué ocurrió [Respuesta 3]? -> [Respuesta 4]
  5. ¿Por qué ocurrió [Respuesta 4]? -> **(Causa Raíz Real)**
- **Atajo que intentó tomar la IA (si aplica):** ¿Qué solución superficial o perjudicial sugirió el asistente?
- **Solución Correcta Implementada:** ¿Qué cambio de ingeniería resolvió el problema de fondo?
- **Invariante / Regla Nueva para el AGENTS.md:** ¿Qué regla debe obedecer todo asistente futuro para no repetir esto?
- **Prueba Automatizada de Regresión:** `tests/...`
```

---

## 📋 Registro Histórico de Aprendizajes

### [ERR-001] Fuga de Clave Secreta en Código Frontend
- **Fecha:** 2026-10-10
- **Módulo / Archivo afectado:** `src/frontend/app.js`
- **Síntoma Inicial:** La prueba de escaneo de secretos del Quality Gate falló reportando una clave de servicio expuesta.
- **Análisis de los 5 Porqués:**
  1. ¿Por qué falló el Quality Gate? -> Porque encontró `SUPABASE_SERVICE_ROLE_KEY` en `app.js`.
  2. ¿Por qué estaba esa clave allí? -> Porque la IA la usó para hacer una consulta a la base de datos directo desde el navegador.
  3. ¿Por qué lo hizo directo desde el navegador? -> Para ahorrarse crear un endpoint en el backend.
  4. ¿Por qué no podía usar la clave pública anon? -> Porque la tabla no tenía políticas RLS configuradas y daba error de permisos.
  5. ¿Por qué no tenía RLS? -> **Causa Raíz:** Se crearon tablas en la base de datos sin ejecutar las políticas de seguridad mínimas.
- **Atajo de la IA:** Usar la llave de administrador con permisos totales en lugar de crear la política de seguridad adecuada.
- **Solución Correcta Implementada:** Activación de Row Level Security (RLS) en la tabla y uso exclusivo de la clave pública `anon` en el cliente.
- **Invariante para el Asistente:** Prohibido usar claves de servicio o secretas en cualquier archivo que viaje al cliente.

---

### [ERR-002] Mensajes Duplicados en Webhook por Reintento Externo
- **Fecha:** 2026-10-10
- **Módulo / Archivo afectado:** `src/webhooks/receptor.ts`
- **Síntoma Inicial:** Al recibir mensajes en horas pico, el usuario recibía dos respuestas idénticas.
- **Análisis de los 5 Porqués:**
  1. ¿Por qué se enviaron dos respuestas? -> Porque el webhook se ejecutó dos veces con el mismo evento.
  2. ¿Por qué el proveedor envió el evento dos veces? -> Porque nuestro servidor tardó más de 5 segundos en responder.
  3. ¿Por qué tardó más de 5 segundos? -> Porque se llamó a una API externa de forma síncrona antes de responder el HTTP 200.
  4. ¿Por qué se procesó la segunda vez si ya se había atendido? -> Porque no existía un registro de eventos ya atendidos.
  5. ¿Por qué no existía el registro? -> **Causa Raíz:** Falta de un mecanismo de idempotencia por identificador de evento único.
- **Atajo de la IA:** Poner un retraso artificial (`setTimeout`) en lugar de registrar el ID en la base de datos.
- **Solución Correcta Implementada:** Guardar el ID de mensaje en una tabla `eventos_procesados` con clave primaria antes de procesar y responder 200 OK de inmediato.
- **Invariante para el Asistente:** Todo receptor de webhook debe ser idempotente y responder antes de 200ms.
