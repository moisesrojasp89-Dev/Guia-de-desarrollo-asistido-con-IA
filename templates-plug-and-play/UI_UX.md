# 🎨 UI/UX Design System Harness & Guardrails (`UI_UX.md`)

> **Constitución Visual del Proyecto:** Este archivo define las reglas arquitectónicas innegociables para el diseño de interfaces, estilos CSS y componentes. Cualquier asistente de Inteligencia Artificial (Cursor, Antigravity, Claude Code, Copilot) o desarrollador humano que genere o modifique código de frontend **debe cumplir estrictamente con estas directivas**.

---

## 🚫 1. Los 7 Mandamientos Inviolables de Diseño

1. **CERO `!important`:**  
   Queda terminantemente prohibido el uso de `!important` en cualquier archivo CSS, SCSS, Tailwind config o componente. La especificidad debe mantenerse plana `(0, 1, 0)` usando clases semánticas, `@layer` o pseudo-clases como `:where()`.
2. **CERO Códigos Hardcodeados ni Números Mágicos:**  
   Prohibido usar valores de color hexadecimales (`#...`), RGB o HSL directamente en los componentes. Prohibido usar espaciados aleatorios (`padding: 13px; margin: 27px;`). Todo valor visual debe provenir exclusivamente de los tokens de diseño (`var(--...)`).
3. **Respetar la Cascada Natural y el Flujo del DOM:**  
   No romper el flujo con `position: absolute` innecesarios para centrar cosas. Prohibido usar `width: 100vw` (provoca scroll horizontal no deseado por la barra de desplazamiento). Usar `width: 100%`.
4. **Centralización Canónica de Layout y Navbar:**  
   Todo el contenido principal y la barra de navegación deben vivir dentro del **Contenedor Sagrado** (`max-width: var(--max-width-container, 1200px); margin-inline: auto; padding-inline: var(--space-4)`).
5. **Mobile-First Estricto:**  
   Los estilos base se definen para pantallas móviles. Las pantallas grandes se adaptan progresivamente mediante `@media (min-width: ...)` (nunca al revés con `max-width` descendente caótico).
6. **Ergonomía Táctil y Accesibilidad (WCAG):**  
   Todo elemento interactivo (botones, enlaces, inputs) debe tener un área táctil mínima de **44x44 píxeles** (`min-height: 44px; min-width: 44px`). Inputs con fuente mínima de `16px` para evitar el zoom indeseado en dispositivos iOS Safari.
7. **Los 4 Estados Sagrados Obligatorios:**  
   Todo componente o vista que cargue datos debe tener implementados explícitamente sus 4 estados:
   - ⏳ **Loading:** Skeleton o spinner que no deforme la pantalla.
   - 📭 **Empty:** Mensaje ilustrativo con llamada a la acción cuando no hay datos.
   - ⚠️ **Error:** Alerta clara y legible con botón para reintentar.
   - ✅ **Success:** Visualización armoniosa de los datos.

---

## 📐 2. Sistema Canónico de Tokens de Diseño (`:root`)

Copia y pega este bloque en tu archivo `tokens.css` o `globals.css`:

```css
@layer reset, base, tokens, layout, components, utilities;

@layer tokens {
  :root {
    /* ========================================================================
       1. COLORES SEMÁNTICOS (Modo Claro por Defecto)
       ======================================================================== */
    --color-primary: #2563eb;          /* Azul de acción principal */
    --color-primary-hover: #1d4ed8;
    --color-primary-contrast: #ffffff;
    
    --color-success: #16a34a;          /* Confirmaciones y pagos exitosos */
    --color-warning: #d97706;          /* Alertas y advertencias */
    --color-danger: #dc2626;           /* Errores y acciones destructivas */
    --color-danger-hover: #b91c1c;

    --bg-app: #f8fafc;                 /* Fondo global de la ventana */
    --bg-surface: #ffffff;             /* Fondo de tarjetas, navbar y modales */
    --bg-surface-hover: #f1f5f9;
    --bg-subtle: #f1f5f9;

    --text-main: #0f172a;              /* Texto principal de alto contraste */
    --text-muted: #64748b;             /* Texto secundario y descriptivo */
    --text-disabled: #94a3b8;
    
    --border-subtle: #e2e8f0;          /* Separadores y bordes suaves */
    --border-strong: #cbd5e1;

    /* ========================================================================
       2. ESCALA MATEMÁTICA DE ESPACIADO (Múltiplos de 4px / 8px)
       ======================================================================== */
    --space-0: 0;
    --space-1: 0.25rem;  /*  4px */
    --space-2: 0.5rem;   /*  8px */
    --space-3: 0.75rem;  /* 12px */
    --space-4: 1rem;     /* 16px (Base) */
    --space-5: 1.25rem;  /* 20px */
    --space-6: 1.5rem;   /* 24px */
    --space-8: 2rem;     /* 32px */
    --space-10: 2.5rem;  /* 40px */
    --space-12: 3rem;    /* 48px */
    --space-16: 4rem;    /* 64px */

    /* ========================================================================
       3. TIPOGRAFÍA FLUIDA MODERNA (clamp)
       ======================================================================== */
    --font-family-base: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    --font-family-mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;

    --font-size-xs: clamp(0.75rem, 0.1vw + 0.72rem, 0.8125rem);
    --font-size-sm: clamp(0.8125rem, 0.2vw + 0.78rem, 0.875rem);
    --font-size-base: 1rem;                                         /* 16px */
    --font-size-lg: clamp(1.125rem, 0.4vw + 1rem, 1.25rem);         /* 18px - 20px */
    --font-size-xl: clamp(1.25rem, 0.8vw + 1.1rem, 1.5rem);         /* 20px - 24px */
    --font-size-2xl: clamp(1.5rem, 1.5vw + 1.2rem, 2rem);           /* 24px - 32px */
    --font-size-3xl: clamp(2rem, 3vw + 1.5rem, 3rem);              /* 32px - 48px */

    --line-height-tight: 1.25;
    --line-height-normal: 1.5;
    --line-height-relaxed: 1.75;

    /* ========================================================================
       4. RADIOS, SOMBRAS Y ELEVACIÓN
       ======================================================================== */
    --radius-sm: 6px;
    --radius-md: 10px;
    --radius-lg: 16px;
    --radius-full: 9999px;

    --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
    --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
    --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);

    /* ========================================================================
       5. Z-INDEX ESTRATIFICADO (Cero z-index: 999999)
       ======================================================================== */
    --z-negative: -1;
    --z-base: 0;
    --z-sticky: 100;
    --z-dropdown: 200;
    --z-backdrop: 300;
    --z-modal: 400;
    --z-toast: 500;
    --z-tooltip: 600;

    /* ========================================================================
       6. DIMENSIONES ESTRUCTURALES DE LAYOUT
       ======================================================================== */
    --max-width-container: 1200px;
    --max-width-readable: 68ch;
    --navbar-height: 64px;
  }

  /* Modo Oscuro Automático */
  @media (prefers-color-scheme: dark) {
    :root {
      --bg-app: #0b0f19;
      --bg-surface: #1e293b;
      --bg-surface-hover: #334155;
      --bg-subtle: #1e293b;

      --text-main: #f8fafc;
      --text-muted: #94a3b8;
      --text-disabled: #64748b;

      --border-subtle: #334155;
      --border-strong: #475569;

      --color-primary: #3b82f6;
      --color-primary-hover: #60a5fa;
      --color-primary-contrast: #0f172a;
    }
  }
}
```

---

## 🧭 3. Estructura de Layout Canónica (Navbar + Contenedor Sagrado)

```html
<!-- ESTRUCTURA BASE HTML5 SEMÁNTICA -->
<div class="app-layout">
  <!-- 1. HEADER / NAVBAR CENTRALIZADO -->
  <header class="app-header">
    <div class="app-header__inner container-sagrado">
      <a href="/" class="app-logo">
        <span class="logo-text">MiProyecto</span>
      </a>
      
      <nav class="app-nav" aria-label="Navegación principal">
        <ul class="app-nav__list">
          <li><a href="#inicio" class="nav-item is-active">Inicio</a></li>
          <li><a href="#servicios" class="nav-item">Servicios</a></li>
          <li><a href="#precios" class="nav-item">Precios</a></li>
        </ul>
      </nav>

      <div class="app-header__actions">
        <button class="btn btn-primary" type="button">Comenzar</button>
      </div>
    </div>
  </header>

  <!-- 2. CONTENIDO PRINCIPAL CENTRADO -->
  <main class="app-main container-sagrado">
    <!-- Vistas, formularios o tablas aquí dentro -->
  </main>

  <!-- 3. PIE DE PÁGINA CENTRADO -->
  <footer class="app-footer">
    <div class="app-footer__inner container-sagrado">
      <p>&copy; 2026 MiProyecto. Todos los derechos reservados.</p>
    </div>
  </footer>
</div>
```

### CSS Estructural:
```css
@layer layout {
  /* El Contenedor Sagrado que centra todo sin desbordes */
  .container-sagrado {
    width: 100%;
    max-width: var(--max-width-container);
    margin-inline: auto;
    padding-inline: var(--space-4);
  }

  .app-header {
    position: sticky;
    top: 0;
    z-index: var(--z-sticky);
    width: 100%;
    background-color: var(--bg-surface);
    border-bottom: 1px solid var(--border-subtle);
  }

  .app-header__inner {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: var(--navbar-height);
    gap: var(--space-4);
  }

  .app-nav__list {
    display: flex;
    align-items: center;
    gap: var(--space-6);
    list-style: none;
    margin: 0;
    padding: 0;
  }

  .app-main {
    padding-block: var(--space-8);
    min-height: calc(100vh - var(--navbar-height) - 100px);
  }
}
```

---

## 📋 4. Checklist de Validación UI/UX antes de Entregar Código

Antes de dar por finalizada cualquier tarea de frontend, ejecuta esta lista de verificación:

- [ ] **1. Cero `!important`:** ¿El código carece de `!important`?
- [ ] **2. Cero Colores Hex Sueltos:** ¿Todos los colores usan `var(--color-...)` o `var(--bg-...)`?
- [ ] **3. Cero Espaciados Mágicos:** ¿Márgenes y paddings son múltiplos de 4px/8px (`var(--space-...)`)?
- [ ] **4. Navbar y Layout Centrados:** ¿El contenido se mantiene acotado en pantallas grandes (`max-width: 1200px`) y centrado con `margin-inline: auto`?
- [ ] **5. Cero Scroll Horizontal (`overflow-x`):** ¿Se evitó `width: 100vw` y la página no se balancea horizontalmente en móviles?
- [ ] **6. Ergonomía Táctil Móvil:** ¿Todos los botones e inputs interactivos miden al menos `44px` de alto?
- [ ] **7. Estados de Feedback:** ¿El componente maneja estados de *Loading*, *Empty*, *Error* y *Success* sin parpadear?
- [ ] **8. Semántica HTML5:** ¿Se usaron etiquetas `<header>`, `<nav>`, `<main>`, `<button>` (no `<div onClick>`)?
