# ✨ Microinteracciones y Feedback Inmediato

> *"Si un usuario presiona un botón y no pasa nada durante medio segundo, asumirá que el botón está roto y lo presionará tres veces más."*

---

## ⚡ La Regla de los 100 Milisegundos

El cerebro humano percibe cualquier respuesta que tarde más de **100 milisegundos** como una pausa o retraso.
Cuando un usuario hace clic en tu aplicación:
1. **0 – 100ms:** Debe haber retroalimentación física o visual inmediata (el botón cambia ligeramente de color, se hunde suavemente o muestra un micro-indicador).
2. **100ms – 1s:** El usuario percibe que el sistema está trabajando pero mantiene el foco.
3. **> 1s:** El usuario empieza a dudar si la aplicación se congeló.

---

## 🎯 Las 3 Microinteracciones Obligatorias

### 1. El Estado Activo en Botones (`:active`)
Haz que el usuario sienta que realmente presionó una tecla:
```css
.btn-primary:active {
  transform: scale(0.98); /* Se encoge un 2% al tocarlo */
  filter: brightness(0.92);
}
```

### 2. Deshabilitar Botones de Envío Inmediatamente
En formularios de pago o creación de cuentas:
```javascript
botonPagar.addEventListener('click', async () => {
  // 1. Deshabilitamos de inmediato para evitar envíos dobles
  botonPagar.disabled = true;
  botonPagar.classList.add('is-loading');
  botonPagar.textContent = 'Procesando pago...';
  
  // 2. Enviamos la petición por internet
  await procesarPago();
});
```

### 3. Notificaciones Toast No Invasivas
En lugar de lanzar alertas invasivas del navegador (`alert("Guardado")`) que congelan la pantalla y obligan a pulsar "Aceptar":
- Usa una pequeña notificación suave (*Toast*) en la esquina inferior o superior que aparece con una transición limpia y desaparece sola a los 3 segundos.
