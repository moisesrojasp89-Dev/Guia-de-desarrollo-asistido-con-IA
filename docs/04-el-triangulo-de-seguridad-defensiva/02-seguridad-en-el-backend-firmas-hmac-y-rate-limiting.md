# 🛡️ Seguridad en el Backend: Firmas Criptográficas (HMAC) y Rate Limiting

> *"Tener una URL pública sin validar la firma es como dejar la puerta de tu casa abierta con un cartel que dice: 'Por favor, solo entren mis amigos'."*

---

## 🔏 1. La Firma Criptográfica HMAC: El Sello de Cera Real

Cuando conectas tu aplicación a servicios externos (como **Stripe** para cobrar o **Meta / WhatsApp Cloud API** para recibir mensajes), esos servicios te envían datos a través de una URL pública llamada **Webhook**.

### El Peligro del Impostor:
Cualquier persona en internet que descubra la URL de tu webhook (`https://tuweb.com/api/webhook`) podría enviar una petición falsa fingiendo ser Stripe:
```json
{
  "evento": "pago_completado",
  "usuario_id": "hacker_99",
  "monto": 5000
}
```
Si tu backend acepta el JSON a ciegas, le regalarías acceso a un impostor sin haber recibido un solo centavo.

---

### ¿Cómo funciona la Firma HMAC?
En la antigüedad, los reyes sellaban sus cartas con un anillo y cera caliente. Si la carta llegaba sin el sello intacto, los guardias la destruían de inmediato.

En el mundo digital:
1. Tú y el servicio externo (ej. Stripe o Meta) comparten un secreto privado (*Webhook Secret*).
2. Cuando el servicio te envía un mensaje, calcula una firma matemática usando el contenido del mensaje + tu secreto secreto, y lo envía en una cabecera:  
   `x-hub-signature-256: sha256=a8f9b...`
3. Tu backend toma el mensaje crudo (*raw body*), calcula la misma firma con su copia del secreto y las compara.
4. **Si coinciden al 100%:** El mensaje es auténtico.
5. **Si difieren en un solo carácter:** Rechazas la petición con código `401 Unauthorized` de inmediato.

---

## 🛑 2. Rate Limiting: El Portero Anti-Spam

¿Qué pasa si un usuario malicioso o un bot decide enviar 10,000 peticiones por segundo a tu formulario de inicio de sesión o a tu endpoint de generación con IA?
- Tu base de datos colapsará por exceso de conexiones.
- Si usas APIs de pago (como OpenAI o Gemini), tu factura se disparará en cuestión de minutos.
- Tu servidor legítimo dejará de responder a usuarios reales (*Ataque de Denegación de Servicio / DoS*).

### La Solución: El Cubo de Tokens (Rate Limiting)
El **Rate Limiting** es como el portero de una discoteca:
- Permite que cada dirección IP haga un máximo razonable de peticiones (por ejemplo, **5 intentos de login por minuto** o **60 peticiones de lectura por minuto**).
- Si alguien supera el límite, el servidor responde instantáneamente con un código HTTP `429 Too Many Requests` sin tocar la base de datos ni gastar tokens de IA.
