# 🤖 ¿Qué es un Arnés de Instrucciones (AGENTS.md y Similares)?

> *"Si no le pones límites constitucionales a tu asistente de IA, cada sesión de desarrollo será como contratar a un empleado nuevo que ignora todas las reglas de la empresa. Pero recuerda: un arnés no es un dogma grabado en piedra, sino un documento vivo que evoluciona junto a tu proyecto."*

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

## ⚠️ Un Arnés NO es una Verdad Absoluta: El Principio del Documento Vivo

Uno de los errores más comunes al iniciarse en el desarrollo asistido es buscar en internet un archivo `AGENTS.md` gigantesco de 50 páginas, copiarlo a ciegas y asumir que resolverá todos los problemas por arte de magia.

**Esto es peligroso e ineficiente por dos razones:**
1. **Saturación de Contexto:** Cada palabra en tu arnés consume tokens de la ventana de contexto del modelo. Si tu arnés está lleno de reglas irrelevantes para tu caso específico, el modelo se confunde y empieza a ignorar las reglas verdaderamente importantes.
2. **Diversidad de Proyectos:** Un bot simple de automatización no necesita las mismas reglas que una pasarela de pagos fintech, ni un script de ciencia de datos en Python requiere las directivas de componentes de React.

### El Ciclo Evolutivo de tu Propio Arnés (En 3 Fases):

```mermaid
flowchart LR
    F1["1. FASE SEMILLA\n(Guardrails mínimos:\nsecretos, respeto al código,\ncalidad básica)"] --> F2["2. FASE DE ITERACIÓN\n(Cada error repetitivo de la IA\nse convierte en una nueva regla)")
    F2 --> F3["3. FASE DE PODA\n(Eliminar reglas obsoletas\no innecesarias para ahorrar tokens)"]
    F3 --> F2
```

1. **Fase Semilla (Starter):** Empieza con un conjunto pequeño y sensato de guardrails generales (no exponer contraseñas en Git, no reescribir archivos enteros sin necesidad, no inventar librerías pesadas).
2. **Fase de Iteración (Aprender en el camino):** Cuando notes que la IA insiste en cometer un error particular en tu proyecto (por ejemplo: *"la IA siempre olvida que en este proyecto usamos Tailwind y mete CSS inline"*), **no te limites a corregirla en el chat**. Abre tu `AGENTS.md` y agrega esa regla específica.
3. **Fase de Poda:** Si con el tiempo cambias de librería o el modelo ya domina un patrón de forma natural, borra las reglas que ya no aportan valor para mantener el arnés ágil y liviano.

---

## 🔒 Instrucción de Texto vs. Restricción por Código

Recuerda siempre la jerarquía de seguridad:

* **Una Instrucción de Texto (`AGENTS.md`):**  
  Decirle *"No modifiques el sistema de autenticación"* es una guía de comportamiento. Como los modelos son probabilísticos, en un momento de distracción el modelo puede ignorarla.
* **Una Restricción por Código (Harness Real):**  
  Tener un test automatizado que falle si se altera la función, o revisar el `git diff` antes de aceptar el cambio, es una **ley matemática que el modelo no puede evadir**.

**La regla de oro:**  
Usa `AGENTS.md` como el mapa de navegación ético y técnico de tu asistente; usa **Git y compuertas de calidad automáticas** como el cinturón de seguridad que nunca falla.

> 📖 *Para comenzar con un arnés base modular y adaptable, consulta nuestro modelo didáctico en [`templates-plug-and-play/AGENTS-universal.md`](../../templates-plug-and-play/AGENTS-universal.md).*
