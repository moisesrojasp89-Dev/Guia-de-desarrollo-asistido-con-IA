# ⚡ Circuit Breakers y Patrón Outbox: Cuando las APIs Externas se Caen

> *"Cualquier servicio que dependa de internet se va a caer tarde o temprano. La diferencia entre un amateur y un profesional es qué hace su sistema mientras el otro servicio está caído."*

---

## 💥 La Realidad de las Caídas Externas

No importa si estás conectado a OpenAI, Anthropic, Stripe, SendGrid o WhatsApp:
- En algún momento del año tendrán una caída de 15 minutos o una sobrecarga que aumentará sus tiempos de respuesta a más de 30 segundos.

### ¿Qué le ocurre al sistema desprotegido?
1. 100 usuarios intentan usar la app al mismo tiempo.
2. Cada petición se queda congelada esperando a OpenAI durante 30 segundos.
3. Las conexiones de tu servidor se saturan al 100%.
4. **Tu servidor completo colapsa**, tirando también la página web, el panel de administración y funciones que ni siquiera necesitaban a OpenAI.

---

## 🔌 1. El Circuit Breaker (El Interruptor Eléctrico)

Igual que el disyuntor o fusible de tu casa que "salta" cuando hay un cortocircuito para evitar que se quemen los electrodomésticos:

```text
[ ESTADO CERRADO (Normal) ]
       │
       ▼ (Si 5 peticiones seguidas fallan o tardan >10 segundos)
[ ESTADO ABIERTO (Protegido) ] ──► Responde INMEDIATAMENTE al usuario:
       │                           "El servicio de IA está temporalmente saturado.
       │                            Por favor intenta en 2 minutos."
       │                           (Tu servidor no se satura ni un solo segundo).
       ▼ (Tras 60 segundos de espera)
[ ESTADO MEDIO-ABIERTO ] ─────► Prueba con 1 sola petición piloto:
                                • ¿Pasó? Vuelve a estado CERRADO.
                                • ¿Falló? Se mantiene ABIERTO otros 60s.
```

---

## 📬 2. El Patrón Outbox (La Bandeja de Salida Segura)

Imagina que un cliente acaba de pagar un curso o comprar una entrada, y tu sistema tiene que enviarle un correo o un mensaje de confirmación por WhatsApp.
- ¿Qué pasa si el servidor de correos está caído en ese instante exacto?
- Si intentas enviar el correo directamente en el flujo principal y falla, ¿vas a cancelar la compra del cliente? ¡Claro que no! El cliente ya pagó.

### Cómo funciona el Patrón Outbox:
1. **Paso 1 (Dentro de la transacción de compra):** Guardas la compra del cliente y al mismo tiempo insertas un registro en una tabla local llamada `mensajes_pendientes`:
   ```sql
   INSERT INTO outbox_mensajes (destinatario, tipo, contenido, estado)
   VALUES ('juan@correo.com', 'email_bienvenida', '{...}', 'PENDIENTE');
   ```
2. **Paso 2:** Le respondes al cliente con su pantalla de compra exitosa de inmediato (<200ms).
3. **Paso 3 (Un proceso en segundo plano):** Lee la tabla `outbox_mensajes`:
   - Intenta enviar el correo.
   - Si el proveedor de correo está en línea: lo marca como `'ENVIADO'`.
   - Si el proveedor está caído: espera 1 minuto y lo vuelve a intentar automáticamente.

**Resultado:** Cero correos perdidos, cero cancelaciones traumáticas y una experiencia fluida e invulnerable para tus usuarios.
