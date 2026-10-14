/**
 * 🔏 Validador Criptográfico Universal de Webhooks (HMAC SHA-256)
 *
 * ==============================================================================
 * 📋 QUÉ GARANTIZA ESTA PLANTILLA:
 * • Autenticidad: Demuestra matemáticamente que el mensaje fue emitido por el
 *   proveedor oficial (Meta, Stripe, GitHub, Shopify) y no por un impostor.
 * • Integridad: Comprueba que ni un solo carácter del cuerpo fue alterado.
 * • Protección contra Timing Attacks: Usa `crypto.timingSafeEqual` en tiempo constante.
 *
 * ⚠️ QUÉ NO GARANTIZA (LÍMITES QUE TODO DESARROLLADOR DEBE SABER):
 * • NO evita eventos duplicados: Validar la firma NO es lo mismo que evitar cobros dobles.
 *   Para deduplicar necesitas el cerrojo de Idempotencia en base de datos.
 * • NO protege contra ataques de repetición (Replay Attacks) por sí solo: Si un atacante
 *   intercepta una petición válida y la reenvía 10 minutos después, la firma matemática
 *   sigue siendo válida a menos que verifiques la marca de tiempo (timestamp).
 * ==============================================================================
 */

import crypto from 'node:crypto';

export interface OpcionesVerificacion {
  cuerpoCrudo: string | Buffer;
  firmaRecibida: string;
  secretoWebhook: string;
  prefijoEsperado?: string; // Por ejemplo 'sha256=' en Meta / GitHub
}

export interface OpcionesVerificacionConTiempo extends OpcionesVerificacion {
  timestampRecibido: string | number; // Marca de tiempo enviada en la cabecera
  toleranciaSegundos?: number;        // Tolerancia máxima (ej: 300 segundos = 5 minutos)
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

    // 3. timingSafeEqual evita que un atacante deduzca la clave midiendo nanosegundos de respuesta
    return crypto.timingSafeEqual(bufferRecibido, bufferCalculado);
  } catch (error) {
    console.error('Error al verificar firma criptográfica:', error);
    return false;
  }
}

/**
 * Valida firma HMAC + marca de tiempo para prevenir ataques de repetición (Estilo Stripe).
 */
export function verificarFirmaConTimestamp({
  cuerpoCrudo,
  firmaRecibida,
  secretoWebhook,
  timestampRecibido,
  toleranciaSegundos = 300, // 5 minutos por defecto
}: OpcionesVerificacionConTiempo): boolean {
  const tiempoActual = Math.floor(Date.now() / 1000);
  const tiempoMensaje = Number(timestampRecibido);

  // 1. Comprobación anti-replay: el mensaje no debe tener más de 5 minutos de antigüedad
  if (isNaN(tiempoMensaje) || Math.abs(tiempoActual - tiempoMensaje) > toleranciaSegundos) {
    console.warn('⚠️ Webhook rechazado por expiración de timestamp (posible ataque replay).');
    return false;
  }

  // 2. Concatenamos timestamp + cuerpo crudo según el protocolo oficial
  const payloadConTiempo = `${tiempoMensaje}.${typeof cuerpoCrudo === 'string' ? cuerpoCrudo : cuerpoCrudo.toString('utf-8')}`;

  return verificarFirmaHMAC({
    cuerpoCrudo: payloadConTiempo,
    firmaRecibida,
    secretoWebhook,
    prefijoEsperado: 'v1=', // Formato v1 de Stripe
  });
}

// ==============================================================================
// 🧪 CÓMO PROBAR QUE LA VERIFICACIÓN REALMENTE FALLA CUANDO DEBE FALLAR:
// ==============================================================================
/*
// PRUEBA NEGATIVA 1: Firma alterada por un hacker
const hackValido = verificarFirmaHMAC({
  cuerpoCrudo: '{"evento":"pago_completado"}',
  firmaRecibida: 'sha256=1234567890abcdeffalsificado0000000000000000000000000000000000000000',
  secretoWebhook: 'mi_secreto_seguro_123'
});
console.log('Resultado (debe ser false):', hackValido); // false ✔

// PRUEBA NEGATIVA 2: Cuerpo del mensaje modificado en tránsito
const manipulado = verificarFirmaHMAC({
  cuerpoCrudo: '{"evento":"pago_completado","monto":9999}', // Alguien infló el monto
  firmaRecibida: 'sha256=' + hashOriginal, // Firma del mensaje sin el monto inflado
  secretoWebhook: 'mi_secreto_seguro_123'
});
console.log('Resultado (debe ser false):', manipulado); // false ✔
*/
