# 🤝 Guía de Contribución: Manteniendo la Guía Real, Útil y Libre de Humo

¡Gracias por querer sumar a este proyecto abierto! Este repositorio no busca coleccionar teoría abstracta ni inflar el ego de nadie. Nuestra meta es **facilitar el camino a cualquier persona que quiera construir software confiable asistido por Inteligencia Artificial**.

---

## 🎯 Principios No Negociables para Contribuir

1. **Pragmatismo de Trinchera:**  
   Si sugieres un concepto, acompáñalo de un ejemplo tangible o una lección real. No aceptamos sugerencias que suenen bien en Twitter pero se rompan en un servidor de \$5 USD.
2. **Neutralidad de Casos de Uso:**  
   Las explicaciones y plantillas deben ser universales (aplicables a una tienda, un SaaS, un bot, una app móvil o un sistema contable). Si usas un ejemplo ilustrativo, asegúrate de que cualquier persona de otra disciplina pueda entenderlo.
3. **El Paso Cero Primero:**  
   Toda nueva técnica debe respetar la filosofía de: *diseñar en servilleta antes de codificar*.
4. **Lenguaje Claro y Respetuoso:**  
   Evita tecnicismos innecesarios. Si debes introducir un término técnico complejo (por ejemplo, *idempotencia*, *HMAC*, *AST*, *RLS*), explícalo primero con una analogía cotidiana comprensible para cualquier persona.
5. **Calidad Probada:**  
   Si aportas código, scripts o plantillas SQL/Docker, pruébalos primero en tu entorno local. No aceptamos fragmentos de código ficticios o rotos.

---

## 🛠️ ¿Cómo Proponer Cambios o Nuevas Guías?

### 1. Corregir una errata o mejorar una explicación
- Haz un **Fork** del repositorio.
- Crea una rama descriptiva: `git checkout -b fix/mejora-analogia-webhooks`.
- Realiza tus ajustes asegurándote de mantener el tono pedagógico y cercano.
- Haz commit con un mensaje claro: `docs: clarificar concepto de idempotencia con analogia del cartero`.
- Envía un **Pull Request**.

### 2. Aportar un nuevo caso al Catálogo de Errores (5-Whys)
Si descubriste un patrón recurrente donde los modelos de IA fallan (por ejemplo: inventar librerías obsoletas, mezclar estilos en cascada, o saltarse migraciones):
- Abre un issue o agrega una entrada a [`templates-plug-and-play/self_learning_error_catalog.md`](templates-plug-and-play/self_learning_error_catalog.md).
- Incluye el síntoma, los 5-porqués, el atajo que tomó la IA y la regla inquebrantable para prevenirlo.

### 3. Aportar una nueva plantilla o script
- Añade el archivo en `templates-plug-and-play/` con comentarios claros y directos.
- Asegúrate de que no dependa de hardware costoso (recuerda nuestra regla de respeto por computadoras con recursos modestos).

---

## 📋 Lista de Verificación antes de Enviar tu PR

- [ ] ¿El texto evita frases pretenciosas o absolutas ("el único método", "infalible", "revolucionario")?
- [ ] ¿Los enlaces relativos en Markdown funcionan correctamente?
- [ ] ¿Las analogías son cotidianas e inclusivas para cualquier nivel técnico?
- [ ] ¿El código propuesto funciona de manera reproducible?

¡Gracias por poner tu experiencia de trinchera al servicio de los demás!
