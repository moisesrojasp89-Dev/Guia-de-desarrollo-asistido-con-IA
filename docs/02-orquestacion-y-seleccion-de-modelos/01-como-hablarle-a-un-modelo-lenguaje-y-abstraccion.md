# 🗣️ Cómo Hablarle a un Modelo: Lenguaje, Precisión y Abstracción

> *"Un modelo no lee tu mente ni tus intenciones: solo lee tokens. La ambigüedad en la pregunta garantiza la mediocridad en la respuesta."*

---

## 🎭 Los Tres Niveles de Abstracción al Dialogar con una IA

Cuando le pides algo a un modelo, puedes situarte en tres niveles de abstracción:

```text
Nivel Alto (Demasiado vago):
"Arregla el diseño para que se vea más moderno y profesional."
❌ Resultado: Cambia todas las fuentes, rompe los márgenes y borra tus colores corporativos.

Nivel Medio (Equilibrado y arquitectónico - RECOMENDADO):
"Ajusta los botones de llamada a la acción para que usen un padding de 12px 24px, 
borde redondeado de 8px y respeten la variable CSS --primary-color. 
No toques las tipografías globales ni el contenedor padre."
✅ Resultado: Cambio quirúrgico, limpio y sin efectos colaterales.

Nivel Hiper-Bajo (Micro-gestión excesiva):
"En la línea 45 escribe un punto y coma y luego baja dos líneas y pon un corchete."
⚠️ Ineficiente: Pierdes la capacidad de razonamiento del modelo y tardas el triple.
```

---

## 🧱 La Estructura de 4 Partes de un Prompt de Alto Impacto

Cada vez que pidas un cambio sustancial en tu código, organiza tu instrucción en estas 4 partes:

### 1. Rol y Contexto Restrictivo
*Ejemplo:* *"Actúa como un desarrollador frontend enfocado en rendimiento y accesibilidad web."*

### 2. El Objetivo Claro (Qué lograr)
*Ejemplo:* *"Necesitamos agregar un indicador de carga visual tipo spinner en el botón de pago cuando el usuario hace clic."*

### 3. Las Restricciones e Invariantes (Qué NO tocar)
*Ejemplo:* 
- *"Usa únicamente CSS puro, no instales librerías de iconos."*
- *"El botón debe deshabilitarse (`disabled`) mientras carga para evitar dobles clics."*
- *"No modifiques la función que envía la petición al backend (`procesarPago`)."*

### 4. Formato de Salida Esperado
*Ejemplo:* *"Muestra únicamente el bloque CSS nuevo y el fragmento del botón modificado. No reescribas el archivo entero."*

---

## 🚫 Las 3 Frases Tóxicas que Debes Eliminar de tu Vocabulario

1. ❌ *"Haz lo que creas mejor."*  
   👉 **Corrección:** La IA creerá que lo mejor es lo más llamativo o lo más complejo. Dile tú exactamente qué esperas.
2. ❌ *"Refactoriza todo el archivo para mejorarlo."*  
   👉 **Corrección:** Reescribir un archivo completo borra lógica sutil que resolviste días atrás. Especifica siempre: *"Refactoriza únicamente la función X para reducir su complejidad"*.
3. ❌ *"Creo que hay un error, revísalo."*  
   👉 **Corrección:** Copia el mensaje exacto del terminal o de la consola del navegador: *"Al ejecutar `npm test`, la prueba `validarUsuario` arrojó el error `TypeError: Cannot read property 'email' of undefined` en la línea 24"*.
