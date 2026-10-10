# 🕵️ La Técnica de los 5 Porqués para Depurar Bugs

> *"Poner un parche rápido sobre el síntoma sin entender la causa raíz es como tomar un analgésico para calmar el dolor de un clavo enterrado en el pie: el dolor se calma 10 minutos, pero la infección sigue creciendo."*

---

## 🚗 El Origen Industrial: El Método de Toyota

La técnica de los **5 Porqués** fue creada por Sakichi Toyoda en la automotriz Toyota. Su principio es demoledor:  
Ante cualquier fallo, debes preguntar **«¿Por qué ocurrió?»** al menos 5 veces sucesivas hasta dar con la causa sistémica real.

---

## 💻 Ejemplo Real en Desarrollo Asistido por IA

**El Síntoma:** El sistema cobró dos veces a un cliente al pagar su suscripción.

1. **¿Por qué cobró dos veces?**  
   Porque la función `procesarPago()` se ejecutó dos veces en un intervalo de 3 segundos.
2. **¿Por qué se ejecutó dos veces?**  
   Porque la pasarela de pagos envió el evento del webhook dos veces consecutivas.
3. **¿Por qué la pasarela reintentó el evento?**  
   Porque nuestro servidor tardó 7 segundos en responder y la pasarela asumió un timeout.
4. **¿Por qué tardó 7 segundos en responder?**  
   Porque nuestro código intentó generar un PDF de factura y enviarlo por correo antes de responderle el `200 OK` al webhook.
5. **¿Por qué se hizo todo en el mismo hilo bloqueante y sin validar duplicados?**  
   *(LA CAUSA RAÍZ REAL):*  
   Porque no teníamos una tabla de verificación de **idempotencia** (`eventos_procesados`) ni un patrón de tareas en segundo plano.

---

### La Diferencia de Soluciones:
* **El parche mediocre de la IA (Nivel 1):** Poner un botón de alerta en la web diciendo *"Por favor no recargue la página"*. (El fallo seguirá ocurriendo).
* **La solución arquitectónica real (Nivel 5):**
  1. Responder `200 OK` a la pasarela en menos de 200 milisegundos tras verificar la firma HMAC.
  2. Implementar cerrojo de **idempotencia** por `evento_id`.
  3. Mover la generación de facturas a una tarea en segundo plano (*Outbox*).

El problema queda resuelto para siempre.
