# 📓 El Catálogo de Errores Persistente: Aprendizaje Continuo

> *"Errar es de humanos y de inteligencias artificiales; pero tropezar dos veces con la misma piedra en el mismo repositorio es negligencia de ingeniería."*

---

## 🧠 La Pérdida de Memoria entre Sesiones

Los desarrolladores que no usan un catálogo persistente viven atrapados en el "Día de la Marmota":
- El lunes, la IA comete un error con los husos horarios (`UTC` vs hora local).
- El desarrollador gasta 2 horas corrigiéndolo.
- Tres semanas después, abren otra conversación, la IA vuelve a sugerir código con hora local sin UTC, y **el bug reaparece en producción**.

---

## 🗃️ El Catálogo 5-Whys (`self_learning_error_catalog.md`)

Un **Catálogo de Errores Persistente** es un archivo de Markdown en la carpeta de documentación de tu proyecto donde registras cada fallo resuelto siguiendo este formato:

```markdown
### [ERR-014] Doble cobro en suscripciones por reintento de Webhook
- **Fecha:** Octubre 2026
- **Síntoma:** Clientes reportaron cobros duplicados al pagar en horas de alta demanda.
- **Causa Raíz (5-Whys):** Ausencia de cerrojo de idempotencia en la recepción del webhook y timeout por bloqueo en generación de factura.
- **Atajo que intentó tomar la IA:** Quiso meter un `sleep(2)` para esperar la red en lugar de registrar el ID en base de datos.
- **Invariante / Regla Nueva Impuesta:** 
  Toda tabla de webhooks DEBE verificar `event_id` único antes de procesar y responder 200 OK en <200ms.
- **Prueba añadida:** `tests/webhook_idempotency.test.ts`.
```

---

## 🔄 El Bucle de Auto-Mejora
En tu archivo de instrucciones `AGENTS.md`, colocas este mandato:
> *"Antes de proponer una corrección a un fallo, consulta obligatoriamente `self_learning_error_catalog.md`. Si el problema coincide con un patrón previo, aplica la solución validada y no repitas el atajo prohibido."*

Así, tu proyecto **aprende y se vuelve más sabio con cada error**, construyendo una barrera impenetrable de conocimiento técnico.

*(Encuentra la plantilla lista en [`templates-plug-and-play/self_learning_error_catalog.md`](../../templates-plug-and-play/self_learning_error_catalog.md)).*
