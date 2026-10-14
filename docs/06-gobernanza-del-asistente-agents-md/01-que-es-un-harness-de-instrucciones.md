# 🤖 ¿Qué es un Arnés de Instrucciones (AGENTS.md y Similares)?

> *"Si no le pones límites constitucionales a tu asistente de IA, cada sesión de desarrollo será como contratar a un empleado nuevo que ignora todas las reglas de la empresa. Pero recuerda: una instrucción en texto orienta; solo las pruebas y Git protegen."*

---

## 🪢 ¿Qué es un "Harness" o Arnés?

En la escalada de montaña, un **arnés** es el equipo de correas y mosquetones de seguridad que te amarra a la cuerda de vida. No te impide escalar ni frena tu agilidad; pero si cometes un error o das un paso en falso, **te sostiene en el aire e impide que caigas al abismo**.

En el desarrollo de software asistido por IA, un archivo de instrucciones persistentes es un documento en la raíz de tu proyecto que el entorno lee automáticamente al inicio de **cada conversación**.

---

## 🗺️ Qué Archivo Reconoce Cada Entorno

No existe un único archivo mágico que todas las herramientas interpreten de forma universal: cada producto tiene su convención oficial:

| Entorno / Asistente | Archivo Oficial Recomendado | ¿Dónde se ubica? |
|---|---|---|
| **Cursor / Windsurf** | `.cursorrules` (o `AGENTS.md`) | Raíz del proyecto |
| **Claude Code (Anthropic)** | `CLAUDE.md` | Raíz del proyecto |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Carpeta `.github/` |
| **Google Antigravity / Universal** | `AGENTS.md` | Raíz del proyecto |

> [!TIP]
> **El Truco del Enlace Simbólico o Copia:**  
> Puedes mantener `AGENTS.md` como tu documento maestro y crear enlaces o copias como `CLAUDE.md` y `.cursorrules` para que todos los editores compartan exactamente las mismas reglas institucionales.

---

## 🏛️ Por qué el Contexto en Memoria No Basta

Cuando hablas con una IA en el chat común:
1. En la sesión de hoy le explicas: *"Usa solo TypeScript estricto y no toques la tabla de facturación"*.
2. El modelo obedece.
3. Mañana abres una nueva sesión de chat: **el modelo olvidó absolutamente todo**.
4. Empieza de nuevo a usar `any`, a inventar librerías raras y a reescribir tus tablas.

Al plasmar tus mandamientos en un archivo de instrucciones persistente:
- El modelo tiene memoria institucional permanente.
- Conoce el objetivo del proyecto, las librerías permitidas, las prohibiciones de seguridad y el comando obligatorio de Quality Gate.
- Cada respuesta que genere estará alineada con tus estándares desde el primer token.

---

## ⚠️ La Diferencia Crucial: Instrucción de Texto vs. Restricción por Código

Este es el matiz de ingeniería más importante que un desarrollador debe comprender:

* **Una Instrucción de Texto (`AGENTS.md`):**  
  Decirle *"No modifiques el sistema de autenticación"* es una orientación educada. Como los modelos son probabilísticos, en un momento de confusión el modelo puede ignorar la frase y modificar el archivo de todos modos.
* **Una Restricción por Código (Harness Real):**  
  Tener una prueba automatizada que falle si se altera la función de autenticación, o revisar el `git diff` antes de aceptar el cambio, es una **ley matemática que el modelo no puede vulnerar**.

**La regla de oro:**  
Usa `AGENTS.md` para guiar la intención del modelo; usa **Git, pruebas unitarias y Quality Gates** para blindar la realidad de tu código.

*(Encuentra nuestra plantilla lista para usar en [`templates-plug-and-play/AGENTS-universal.md`](../../templates-plug-and-play/AGENTS-universal.md)).*
