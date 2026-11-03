# 📜 UI_UX.md: El Arnés de Gobernanza Visual para Agentes

> *"Así como `AGENTS.md` gobierna la arquitectura del backend y las políticas de Git, `UI_UX.md` es la constitución visual que le impide a la IA romper tu interfaz, inventar estilos y degradar la experiencia de usuario."*

---

## 🏛️ Por Qué Necesitas una Constitución Visual Dedicada

Los modelos de lenguaje son propensos a la complacencia visual: cuando les pides una funcionalidad, suelen generar interfaces rápidas pero descuidadas:
- Usan botones sin estado de carga (`loading`).
- Olvidan el diseño en pantallas móviles.
- Meten estilos inline con `style={{ color: 'red' }}`.
- Rompen la paleta de colores usando tonos hexadecimales arbitrarios.
- Clavan `!important` ante el primer roce de especificidad.

Al incluir un archivo maestro **`UI_UX.md`** en la raíz de tu proyecto (o dentro de `.harness/`), le otorgas al asistente un arnés de reglas claras y no negociables que debe consultar antes de escribir una sola línea de HTML o CSS.

---

## 🗺️ Cómo Vincular `UI_UX.md` en tu `AGENTS.md`

Siguiendo el principio de **Progressive Disclosure** (no saturar la ventana de contexto si la tarea no lo amerita), agrega esta cláusula en tu `AGENTS.md` o `.cursorrules`:

```markdown
### 🎨 Directiva de Interfaz y Estilos (UI/UX)
- Si la tarea actual involucra crear, estilizar o refactorizar componentes visuales, páginas web, formularios o archivos CSS/HTML/TSX:
  👉 **Lee OBLIGATORIAMENTE el archivo `UI_UX.md` antes de generar código.**
- Respeta estrictamente los tokens de diseño, la regla de cero `!important`, el centrado de layouts y los 4 estados obligatorios de componentes.
```

---

## 🧱 Las 6 Leyes Constitucionales de `UI_UX.md`

| Ley | Regla Innegociable | Consecuencia de Violación |
|:---:|---|---|
| **1** | **Cero `!important`** | El commit es rechazado por el Quality Gate. Debe resolverse con especificidad plana o `@layer`. |
| **2** | **Cero Códigos Hardcodeados** | Prohibido usar valores hexadecimales (`#...`) o píxeles mágicos (`padding: 13px`). Usar exclusivamente tokens `var(--...)`. |
| **3** | **Cascada Natural y Semántica** | Usar elementos semánticos de HTML5 (`<header>`, `<nav>`, `<main>`, `<button>`). No anidar más de 2 niveles de selectores. |
| **4** | **Layout y Navbar Centralizados** | Los componentes de página deben habitar dentro del contenedor sagrado (`max-width: 1200px; margin-inline: auto`). Prohibido centrar con `position: absolute`. |
| **5** | **Mobile-First & Ergonomía Táctil** | El CSS base se diseña para teléfonos móviles; las pantallas grandes se adaptan con `min-width`. Botones con mínimo 44x44px. |
| **6** | **Los 4 Estados Sagrados** | Todo componente que consuma datos asíncronos debe implementar explícitamente: *Loading*, *Empty*, *Error* y *Success*. |

---

## 🤖 El Sensor Mecánico de Calidad Visual (CSS Quality Gate)

Para que estas reglas no queden en simples sugerencias amables, incluye este chequeo automático en tu script de validación previa a commits:

```bash
#!/bin/bash
# ui_ux_quality_gate.sh - Auditoría mecánica de CSS y componentes

echo "🔍 Auditando guardrails de UI/UX..."

# 1. Comprobar que no exista ningún !important
if git grep -in "!important" -- "*.css" "*.scss" "*.tsx" "*.jsx" "*.vue" "*.html" > /dev/null; then
  echo "❌ ERROR: Se detectó el uso prohibido de '!important':"
  git grep -in "!important" -- "*.css" "*.scss" "*.tsx" "*.jsx" "*.vue" "*.html"
  exit 1
fi

# 2. Comprobar que no haya colores hexadecimales hardcodeados fuera de tokens.css
HEX_VIOLATIONS=$(git grep -inE "#([0-9a-fA-F]{3}){1,2}\b" -- "*.tsx" "*.jsx" "*.vue" ":!*tokens*.css" ":!*theme*.css")
if [ -n "$HEX_VIOLATIONS" ]; then
  echo "⚠️ ADVERTENCIA: Se detectaron colores hexadecimales hardcodeados en componentes:"
  echo "$HEX_VIOLATIONS"
  echo "👉 Reemplázalos por tokens semánticos var(--color-...)"
fi

echo "✅ UI/UX Quality Gate: APROBADO sin violaciones de cascada."
exit 0
```
