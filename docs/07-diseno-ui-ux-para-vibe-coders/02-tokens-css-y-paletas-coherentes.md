# 🎨 Tokens CSS y Paletas Coherentes

> *"Una aplicación profesional no usa 40 tonos de azul diferentes; usa un único sistema de tokens centralizado."*

---

## 🎨 El Síndrome del "Arcoíris Accidental"

Cuando construyes una interfaz pidiéndole cosas a la IA en diferentes sesiones de chat:
- En la sesión del lunes, la IA usa `#3b82f6` para un botón.
- En la del miércoles, usa `#2563eb` para otro botón.
- En la del viernes, usa `#1d4ed8` y le pone una sombra verde extraña.

Al cabo de dos semanas, tu aplicación parece un collage hecho por 10 personas distintas con botones desparejos y fuentes desalineadas.

---

## 🏛️ La Solución: Tokens de Diseño en `:root`

Un **Token de Diseño** es simplemente una variable CSS donde guardas una decisión visual una sola vez:

```css
:root {
  /* 1. Colores de Marca */
  --color-primary: #2563eb;       /* Azul principal */
  --color-primary-hover: #1d4ed8; /* Azul al pasar el cursor */
  --color-success: #16a34a;       /* Verde para pagos y aciertos */
  --color-danger: #dc2626;        /* Rojo para errores */
  
  /* 2. Colores de Fondo y Texto */
  --bg-app: #f8fafc;
  --bg-card: #ffffff;
  --text-main: #0f172a;
  --text-muted: #64748b;
  --border-subtle: #e2e8f0;

  /* 3. Espaciado Matemático y Bordes */
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 16px;
  
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
}
```

---

## 🪄 La Regla de Oro para Pedirle Diseño a la IA

Cada vez que le pidas a tu asistente crear o ajustar un componente visual, agrégale esta cláusula inquebrantable:

> *"Está estrictamente prohibido usar valores de color hexadecimales sueltos (`#...`) o tamaños fijos arbitrarios en el CSS. Utiliza exclusivamente las variables de diseño definidas en `:root` (`var(--color-primary)`, `var(--radius-md)`, etc.)."*

Al hacer esto, si el día de mañana decides cambiar el color de tu marca de azul a verde o morado, **solo cambias una línea en tu archivo CSS** y la aplicación entera se actualizará de forma armoniosa al instante.
