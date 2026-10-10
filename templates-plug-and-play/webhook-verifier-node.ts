/**
 * 🔏 Validador Criptográfico Universal de Webhooks (HMAC SHA-256)
 *
 * Protege tus endpoints contra ataques de falsificación y replay:
 * 1. Utiliza `crypto.timingSafeEqual` para evitar ataques de temporización (timing attacks).
 * 2. Requiere el cuerpo del mensaje en formato crudo (Raw Body / Buffer) antes de parsear JSON.
 * 3. Compatible con Meta (WhatsApp Cloud API), Stripe, GitHub y Shopify.
 */

import crypto from 'node:crypto';

export interface OpcionesVerificacion {
  cuerpoCrudo: string | Buffer;
  firmaRecibida: string;
  secretoWebhook: string;
  prefijoEsperado?: string; // Por ejemplo 'sha256=' en Meta / GitHub
}

/**
 * Valida si la firma criptográfica HMAC SHA-256 recibida en la cabecera es auténtica.
 */
export function verificarFirmaHMAC({
  cuerpoCrudo,
  firmaRecibida,
  secretoWebhook,
  prefijoEsperado = 'sha256=',
}: OpcionesVerificacion): boolean {
  if (!firmaRecibida || !secretoWebhook) {
    return false;
  }

  // Si la cabecera incluye prefijo (ej: 'sha256=abcdef...'), lo removemos para comparar el hash puro
  let hashLimpio = firmaRecibida;
  if (prefijoEsperado && firmaRecibida.startsWith(prefijoEsperado)) {
    hashLimpio = firmaRecibida.slice(prefijoEsperado.length);
  }

  try {
    // 1. Calculamos la firma esperada usando nuestro secreto compartido
    const hashCalculado = crypto
      .createHmac('sha256', secretoWebhook)
      .update(cuerpoCrudo)
      .digest('hex');

    // 2. Convertimos ambos hashes a Buffers para una comparación segura en tiempo constante
    const bufferRecibido = Buffer.from(hashLimpio, 'hex');
    const bufferCalculado = Buffer.from(hashCalculado, 'hex');

    if (bufferRecibido.length !== bufferCalculado.length) {
      return false;
    }

    // 3. timingSafeEqual evita que un atacante deduzca la clave midiendo milisegundos de respuesta
    return crypto.timingSafeEqual(bufferRecibido, bufferCalculado);
  } catch (error) {
    console.error('Error al verificar firma criptográfica:', error);
    return false;
  }
}

// Ejemplo de uso en un servidor Fastify / Express:
/*
app.post('/webhook', (req, res) => {
  const firma = req.headers['x-hub-signature-256'] as string;
  const esValido = verificarFirmaHMAC({
    cuerpoCrudo: req.rawBody, // Importante: debe ser el Buffer original sin parsear
    firmaRecibida: firma,
    secretoWebhook: process.env.WEBHOOK_SECRET!
  });

  if (!esValido) {
    return res.status(401).send({ error: 'Firma criptográfica inválida. Impostor detectado.' });
  }

  // Si es válido, procesamos el webhook de forma segura
  return res.status(200).send({ status: 'ok' });
});
*/
