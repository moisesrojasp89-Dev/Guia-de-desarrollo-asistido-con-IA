# 🔐 Cybersecurity Harness & Hardening Constitution (`SECURITY.md`)

> **Constitución de Seguridad Defensiva del Proyecto:** Este documento establece las reglas inquebrantables de ciberseguridad para Frontend, Backend, Base de Datos, Servidores VPS/Docker e Integraciones con IA. Cualquier asistente agéntico (Claude Code, Cursor, Antigravity, Copilot) o desarrollador humano **tiene estrictamente prohibido generar código que viole estas directivas**.

---

## 🚫 1. Los 10 Mandamientos Inviolables para el Asistente de IA

1. **CERO Secretos en el Frontend o en Git:**  
   Jamás coloques claves privadas (`service_role`, `sk_live_...`, `DATABASE_URL`, `JWT_SECRET`) en archivos del cliente ni con prefijos públicos (`NEXT_PUBLIC_`, `VITE_`). Toda clave vive exclusivamente en `.env` (ignorado en `.gitignore`) y se valida al arrancar el servidor.
2. **CERO Consultas sin Filtro de Propiedad (Anti-IDOR):**  
   Toda consulta, edición o borrado de un recurso (`GET/PUT/DELETE /api/recurso/:id`) debe filtrar simultáneamente por el `id` del recurso **y por el `userId` extraído de la sesión autenticada en el servidor** (`WHERE id = $1 AND user_id = $2`). Nunca confíes en un `userId` enviado en el `req.body` o `req.query`.
3. **CERO Asignación Masiva (`Mass Assignment`):**  
   Prohibido pasar `req.body` directamente a métodos de base de datos (`db.create(req.body)` o `db.update(req.body)`). Todo input debe validarse primero con un esquema estricto (`Zod .strict()` o `Pydantic`) seleccionando únicamente los campos permitidos.
4. **CERO Concatenación de Texto en SQL (Anti-SQLi):**  
   Prohibido usar template strings (`${variable}`) dentro de consultas SQL crudas o métodos como `$queryRawUnsafe`. Toda consulta debe usar *Prepared Statements* / parámetros vinculados (`$1, $2`).
5. **CERO `CORS: *` en Rutas Autenticadas:**  
   Prohibido solucionar errores de CORS con `origin: '*'`. Se debe configurar una lista blanca explícita de orígenes permitidos desde variables de entorno.
6. **CERO Ocultamiento Visual como Seguridad:**  
   Ocultar botones o datos con CSS (`display: none`) o con un `if` en React **no es seguridad**. Si un usuario no tiene permiso para ver un dato, ese campo jamás debe salir en el JSON del servidor.
7. **CERO Puertos Internos Expuestos en Docker (`0.0.0.0`):**  
   En cualquier `docker-compose.yml` de producción, queda prohibido publicar puertos de bases de datos o cachés como `"5432:5432"` o `"6379:6379"` (ya que Docker se salta el firewall UFW). Deben usar redes internas o atarse a localhost: `"127.0.0.1:5432:5432"`.
8. **CERO Llamadas a IA sin Tope Financiero (Anti-Denial of Wallet):**  
   Todo endpoint que invoque un LLM debe tener: límite de caracteres de entrada, `Rate Limiting` estricto por usuario/IP, y parámetro `max_tokens` explícito.
9. **CERO Paquetes Alucinados (Anti-Slopsquatting):**  
   No agregar dependencias desconocidas sin verificar su existencia oficial, popularidad y mantenimiento activo en NPM/PyPI.
10. **CERO Confianza en Webhooks sin Firma HMAC:**  
    Todo webhook entrante (Stripe, MercadoPago, Meta, GitHub) debe verificar criptográficamente su firma (`crypto.timingSafeEqual`) sobre el `rawBody` antes de procesar cualquier lógica.

---

## 🌐 2. Guardrails de Seguridad en el Frontend y Web

### A. Manejo de Sesiones y Tokens
- **Preferir Cookies `HttpOnly`:** Los tokens de sesión o Refresh Tokens deben almacenarse en cookies con las banderas `HttpOnly; Secure; SameSite=Lax` (o `Strict`), haciéndolos invisibles al robo mediante XSS (`localStorage` está prohibido para tokens de larga duración o críticos).

### B. Prevención de XSS y Cabeceras HTTP
- Prohibido el uso de `innerHTML`, `outerHTML` o `dangerouslySetInnerHTML` con datos provenientes de usuarios o de respuestas de LLMs sin pasar primero por `DOMPurify.sanitize()`.
- Todo servidor debe emitir cabeceras de blindaje:
  - `Content-Security-Policy` (restringiendo `script-src` e `img-src`).
  - `Strict-Transport-Security: max-age=31536000; includeSubDomains` (HSTS).
  - `X-Frame-Options: DENY` (Anti-Clickjacking).
  - `X-Content-Type-Options: nosniff`.

---

## ⚙️ 3. Guardrails de Seguridad en el Backend y APIs

### Plantilla Obligatoria para Endpoints Seguros (TypeScript / Express / Next):

```typescript
import { z } from 'zod';

// 1. Esquema estricto (Rechaza campos inyectados como "role: admin")
const CrearOrdenSchema = z.object({
  productoId: z.string().uuid(),
  cantidad: z.number().int().min(1).max(20),
}).strict();

app.post('/api/ordenes', rateLimiter, requireAuth, async (req, res) => {
  // 2. Validación determinista en frontera
  const parseResult = CrearOrdenSchema.safeParse(req.body);
  if (!parseResult.success) {
    return res.status(400).json({ error: 'Datos de entrada inválidos' });
  }

  // 3. El userId SIEMPRE proviene del token verificado en el servidor, NUNCA del body
  const usuarioIdAutenticado = req.user.id;

  // 4. El precio SIEMPRE se consulta en la Base de Datos, NUNCA se acepta desde el frontend
  const producto = await db.producto.findUnique({
    where: { id: parseResult.data.productoId }
  });

  if (!producto) return res.status(404).json({ error: 'Producto no existe' });

  const orden = await db.orden.create({
    data: {
      usuarioId: usuarioIdAutenticado,
      productoId: producto.id,
      cantidad: parseResult.data.cantidad,
      totalCentavos: producto.precioCentavos * parseResult.data.cantidad
    }
  });

  return res.status(201).json(orden);
});
```

### Protección Anti-SSRF y Anti-Path Traversal:
- **Anti-SSRF:** Si el backend realiza `fetch()` a una URL enviada por el usuario, debe validar que el protocolo sea `https:` y bloquear cualquier resolución a IPs privadas/locales (`127.0.0.0/8`, `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`, `169.254.169.254`).
- **Anti-Path Traversal:** Nunca concatenar nombres de archivo del usuario en rutas del sistema. Usar `path.basename()` y comprobar con `path.resolve()` que la ruta comience dentro del directorio autorizado.

---

## 🗄️ 4. Guardrails de Base de Datos (PostgreSQL / Supabase / SQL)

1. **Row Level Security (RLS) Obligatorio:**
   - Toda tabla en Supabase/PostgreSQL expuesta a clientes debe tener `ALTER TABLE nombre ENABLE ROW LEVEL SECURITY;`.
   - Prohibido usar la condición perezosa `USING (auth.uid() IS NOT NULL)`. Toda política debe comprobar pertenencia real: `USING (auth.uid() = user_id)`.
2. **Mínimo Privilegio en Conexiones:**
   - La aplicación en producción no debe conectarse con el superusuario `postgres`. Debe usar un rol `app_runtime` con permisos exclusivos de `SELECT, INSERT, UPDATE, DELETE` (sin `DROP` ni `TRUNCATE`).
3. **Criptografía de Datos:**
   - Contraseñas de usuarios: Hash con **Argon2id** o **bcrypt** (cost $\ge 12$).
   - Secretos/Tokens de terceros almacenados en BD: Encriptados con **AES-256-GCM** usando una llave maestra de entorno.

---

## 🏰 5. Guardrails de VPS, Docker e Infraestructura

1. **Hardening SSH:** `PermitRootLogin no`, `PasswordAuthentication no`, acceso exclusivo mediante llaves criptográficas `Ed25519`.
2. **Firewall UFW + Fail2ban:** Denegar todo tráfico entrante salvo `22/tcp`, `80/tcp` y `443/tcp`.
3. **Docker Seguro:**
   ```yaml
   # ✅ SIEMPRE atar servicios de datos a localhost (127.0.0.1)
   services:
     postgres:
       image: postgres:16-alpine
       ports:
         - "127.0.0.1:5432:5432"
     redis:
       image: redis:7-alpine
       command: redis-server --requirepass ${REDIS_PASSWORD}
       ports:
         - "127.0.0.1:6379:6379"
   ```

---

## 🤖 6. Guardrails para Agentes de IA y LLMs

1. **Ruptura de la Tríada Letal:** Un agente que procesa documentos/webs externas de terceros no puede ejecutar herramientas de escritura o envío de correos sin confirmación explícita del usuario humano (*Human-in-the-Loop*).
2. **Delimitación de Contexto No Confiable:** Todo texto externo debe inyectarse encapsulado en etiquetas `<untrusted_data>...</untrusted_data>` indicando al sistema que ignore cualquier instrucción contenida dentro.
3. **Bloqueo de Exfiltración Markdown:** No renderizar imágenes externas (`![img](https://...)`) generadas por respuestas del LLM.

---

## 🛫 7. Checklist de Auditoría de Seguridad Pre-Commit

- [ ] **1. Cero Secretos Expuestos:** ¿`.env` está en `.gitignore` y no hay llaves hardcodeadas en el código?
- [ ] **2. Propiedad Verificada (Anti-IDOR):** ¿Todas las consultas filtran por el `userId` de la sesión del servidor?
- [ ] **3. Inputs Validados (Anti-Mass Assignment):** ¿Todo `req.body` pasa por un esquema estricto antes de tocar la BD?
- [ ] **4. Precios y Permisos en Servidor:** ¿Los montos a cobrar y roles se leen desde la BD y jamás desde el frontend?
- [ ] **5. SQL Parametrizado:** ¿Cero concatenación de strings en consultas SQL?
- [ ] **6. RLS Activo y Probado:** ¿Todas las tablas tienen RLS habilitado con pruebas negativas para usuarios ajenos?
- [ ] **7. Docker Blindado:** ¿Los puertos de BD/Redis en `docker-compose.yml` tienen el prefijo `127.0.0.1:`?
- [ ] **8. Rate Limiting y Tope de IA:** ¿Los endpoints de login, pagos e IA tienen límite de peticiones y `max_tokens`?
