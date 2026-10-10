# 📱 Mobile First y Ergonomía Táctil

> *"Más del 70% de tus usuarios entrarán desde un teléfono celular sosteniéndolo con una sola mano en movimiento. Si tu botón es más pequeño que la yema de un dedo, tu diseño ha fracasado."*

---

## 👆 La Zona del Pulgar (Thumb Zone)

En una computadora con ratón o trackpad, el cursor tiene una precisión de un solo píxel.  
En un teléfono inteligente, **el cursor es un dedo pulgar humano**:
- No tiene precisión milimétrica.
- El pulgar alcanza cómodamente la parte inferior de la pantalla.
- La parte superior de la pantalla requiere estirar la mano o usar la otra mano.

```text
┌──────────────────────────┐
│   ZONA DIFÍCIL           │  ◄── Títulos, logos, lectura estática
│   (Requiere estirar)     │
├──────────────────────────┤
│   ZONA NATURAL           │  ◄── Contenido navegable, tarjetas
│   (Alcance cómodo)       │
├──────────────────────────┤
│   ZONA FÁCIL             │  ◄── BOTONES DE ACCIÓN PRINCIPAL (Pagar,
│   (El hogar del pulgar)  │      Reservar, Enviar, Barra de navegación)
└──────────────────────────┘
```

---

## 📏 Las 3 Reglas de Ergonomía Táctil que Debes Exigirle a la IA

### 1. El Tamaño Mínimo de Botón: 44px x 44px
Según las directrices de accesibilidad de Apple y Google (WCAG):
- Todo elemento tocable (botones, casillas de verificación, enlaces) debe tener un área táctil mínima de **44 por 44 píxeles** (o `min-height: 48px;` en CSS).
- Botones de 24px provocan clics erróneos y frustración en el usuario.

### 2. Formularios sin Zoom Automático en iPhone (`font-size: 16px`)
En Safari (iOS), si un campo de texto `<input>` tiene un tamaño de fuente menor a `16px`, el navegador **hace un zoom agresivo y automático a la pantalla** cada vez que el usuario toca el campo, desajustando toda la interfaz.
- **La regla obligatoria:** Todo `input`, `select` o `textarea` debe tener `font-size: 16px;` como mínimo en pantallas móviles.

### 3. Inputs con el teclado correcto (`inputmode`)
No hagas que el usuario tenga que cambiar de teclado manualmente:
- Para números de teléfono: `<input type="tel" autocomplete="tel">`.
- Para números de tarjetas o cantidades numéricas: `<input inputmode="numeric" pattern="[0-9]*">` (muestra el teclado con números grandes).
- Para correos electrónicos: `<input type="email" autocomplete="email">`.
