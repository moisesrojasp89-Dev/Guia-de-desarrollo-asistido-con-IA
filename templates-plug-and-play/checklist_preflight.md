# 🛫 Listas de Verificación Pre-Vuelo Proporcionales (Preflight Checklist)

> *"Los pilotos de avión no despegan confiando en su memoria; siguen una lista de verificación paso a paso. Pero un avión ultraligero de paseo no requiere la misma lista de verificación que un Boeing 747 comercial. Elige la lista que corresponda al riesgo real de tu aplicación."*

---

## 🟢 PERFIL A: Web Informativa, Landing Page o Portafolio (Riesgo Bajo)
*Aplica si tu web solo muestra información, no procesa pagos y solo tiene un formulario simple de contacto.*

- [ ] **1. Prueba F12 (Frontend):** Abriste el inspector del navegador (F12) y confirmaste que ninguna API key secreta está expuesta en el JavaScript público.
- [ ] **2. Ergonomía Móvil:** Verificaste que en pantallas de celular los botones miden al menos **44px de alto** y se pueden tocar con el pulgar sin zoom involuntario.
- [ ] **3. Formulario y Anti-Spam:** El formulario de contacto valida el formato de correo electrónico y tiene un límite básico para evitar saturación de mensajes.
- [ ] **4. Enlaces y Rutas:** Todas las páginas internas y enlaces externos abren correctamente (cero errores 404).

---

## 🟡 PERFIL B: Aplicación con Cuentas de Usuario y Base de Datos (Riesgo Medio)
*Aplica si los usuarios inician sesión, guardan notas, reservan turnos o tienen perfiles privados.*

*(Incluye todo lo del Perfil A, más:)*
- [ ] **5. Aislamiento RLS en Base de Datos:** Verificaste que todas las tablas tienen Row Level Security (`ENABLE ROW LEVEL SECURITY`) activo y comprobaste que un usuario 'A' no puede leer ni modificar los datos de un usuario 'B'.
- [ ] **6. Los 4 Estados Sagrados de UI:** Cada vista maneja visualmente los estados de **Cargando (Loading)**, **Lista Vacía (Empty)**, **Fallo con botón de reintentar (Error)** y **Éxito (Success)**.
- [ ] **7. Protección de Rutas Privadas:** Si un usuario cierra sesión o no está autenticado, el sistema lo redirige al login y el backend no le devuelve datos confidenciales.
- [ ] **8. Variables de Entorno en Servidor:** El archivo `.env` está en `.gitignore` y las variables de producción están configuradas en el panel del hosting (Vercel, Render o VPS).

---

## 🔴 PERFIL C: Aplicación Transaccional, Pagos y Misión Crítica (Riesgo Alto)
*Aplica si cobras dinero por tarjeta, procesas compras, manejas historiales médicos o recibes webhooks transaccionales.*

*(Incluye todo lo de los Perfiles A y B, más:)*
- [ ] **9. Validación Criptográfica HMAC:** Los webhooks de pago (Stripe, PayPal, WhatsApp) verifican la firma criptográfica antes de ejecutar cualquier acción de negocio.
- [ ] **10. Cerrojo de Idempotencia:** El receptor de eventos valida identificadores únicos (`event_id` o `wamid`) para no cobrar doble ni responder duplicado ante reintentos de red.
- [ ] **11. Transacciones Atómicas (ACID):** Descontar saldo y entregar producto ocurren dentro de un solo bloque atómico. Si algo falla a la mitad, se cancela todo (*Rollback*).
- [ ] **12. Respuesta Sub-Segundo en Webhooks:** El servidor responde `200 OK` en menos de 1 segundo a las pasarelas externas, delegando tareas pesadas (generación de facturas, correos) a segundo plano.
- [ ] **13. Quality Gate Automatizado Verde:** Ejecutaste el script de inspección (`npm run quality-gate` o `python quality_gate_python.py`) y obtuviste 100% de verificaciones superadas.
- [ ] **14. Copias de Seguridad (Backups):** La base de datos tiene copias de seguridad automáticas diarias activadas.
