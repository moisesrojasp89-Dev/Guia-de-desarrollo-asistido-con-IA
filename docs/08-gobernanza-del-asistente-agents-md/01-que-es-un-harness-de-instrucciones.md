# 🤖 ¿Qué es un Arnés de Instrucciones (AGENTS.md)?

> *"Si no le pones límites constitucionales a tu asistente de IA, cada sesión de desarrollo será como contratar a un empleado nuevo que ignora todas las reglas de la empresa."*

---

## 🪢 ¿Qué es un "Harness" o Arnés?

En la escalada de montaña, un **arnés** es el equipo de correas y mosquetones de seguridad que te amarra a la cuerda de vida. No te impide escalar ni frena tu agilidad; pero si cometes un error o das un paso en falso, **te sostiene en el aire e impide que caigas al abismo**.

En el desarrollo de software asistido por IA, un **Arnés de Instrucciones (`AGENTS.md` o `.cursorrules`)** es un archivo de texto en la raíz de tu proyecto que los editores modernos (Cursor, Windsurf, Claude Code, Copilot, Antigravity) leen automáticamente al inicio de **cada conversación**.

---

## 🏛️ Por qué el Contexto en Memoria No Basta

Cuando hablas con una IA en el chat:
1. En la sesión de hoy le explicas: *"Usa solo TypeScript estricto y no toques la tabla de facturación"*.
2. El modelo obedece.
3. Mañana abres una nueva sesión de chat: **el modelo olvidó absolutamente todo**.
4. Empieza de nuevo a usar `any`, a inventar librerías raras y a reescribir tus tablas.

### El Archivo `AGENTS.md` como Constitución Permanente:
Al plasmar tus mandamientos en `AGENTS.md`:
- El modelo tiene memoria institucional permanente.
- Conoce el objetivo del proyecto, las librerías permitidas, las prohibiciones de seguridad y el comando obligatorio de Quality Gate.
- Cada respuesta que genere estará alineada con tus estándares desde el primer token.

*(Encuentra nuestra plantilla lista para usar en [`templates-plug-and-play/AGENTS-universal.md`](../../templates-plug-and-play/AGENTS-universal.md)).*
