# 🛫 Lista de Verificación Pre-Vuelo (Checklist Preflight de Producción)

> *"Los pilotos de avión no despegan confiando en su memoria; siguen una lista de verificación paso a paso. Antes de abrir tu software al público o cobrar el primer dólar, marca estas 10 casillas."*

---

## 🔒 1. Seguridad Defensiva
- [ ] **La Prueba F12 (Frontend):** Abriste el inspector del navegador (F12) en la pestaña *Network* y *Sources*, y confirmaste que **ninguna clave secreta** (`service_role`, `sk_live`, tokens privados) aparece en el código cliente.
- [ ] **Políticas RLS en Base de Datos:** Verificaste que todas las tablas de PostgreSQL tienen Row Level Security (`ENABLE ROW LEVEL SECURITY`) activado y que un usuario común no puede leer los datos de otros.
- [ ] **Validación de Firmas HMAC:** Los webhooks de pago (Stripe) o mensajería (WhatsApp/Meta) verifican la firma criptográfica antes de procesar cualquier orden.

---

## 🛡️ 2. Resiliencia de Datos
- [ ] **Cerrojo de Idempotencia:** El receptor de webhooks valida identificadores únicos (`event_id` o `wamid`) para no cobrar doble ni responder duplicado si el proveedor reintenta el envío.
- [ ] **Transacciones Atómicas (ACID):** Las operaciones críticas (como descontar saldo y entregar producto) están envueltas en una sola transacción o función RPC protegida.
- [ ] **Respuesta Rápida en Webhooks:** El servidor responde con código `200 OK` en menos de 1 segundo a las pasarelas externas, delegando tareas pesadas a segundo plano.

---

## 📱 3. Experiencia de Usuario (UI/UX)
- [ ] **Los 4 Estados Sagrados:** Cada pantalla o tabla maneja correctamente los estados de **Loading** (cargando), **Empty** (sin datos), **Error** (fallo amigable con reintento) y **Success** (éxito).
- [ ] **Prueba de Pulgar en Celular:** Los botones principales miden al menos **44px de alto**, se tocan cómodamente con una sola mano y el teclado numérico aparece donde corresponde.
- [ ] **Protección Anti-Doble Clic:** Los botones de "Pagar" o "Enviar" se deshabilitan inmediatamente tras el primer toque para evitar envíos múltiples.

---

## 🤖 4. Calidad y Gobernanza
- [ ] **Quality Gate Verde:** Ejecutaste el script de verificación (`npm run quality-gate` o `python quality_gate_python.py`) y obtuviste 100% de verificaciones superadas en verde.
