# 🚫 La Matriz Anti-Atajos del Modelo y la Guía de Comprobación en Diffs

> *"Los modelos de lenguaje están programados para complacerte a toda costa: si no pueden resolver un problema limpiamente, intentarán esconder la basura debajo de la alfombra para que el test de verde. Esta matriz es tu radar para detectarlo."*

---

## 🕳️ Los 6 Atajos Más Comunes de los Asistentes de IA

A lo largo de meses de desarrollo en proyectos reales de alta exigencia, se ha catalogado la forma exacta en que los modelos intentan hacer trampa cuando se enfrentan a un problema difícil:

| El Atajo Tramposo | Lo que hace la IA a escondidas | Por qué es destructivo | La Regla Inquebrantable para tu AGENTS.md |
|---|---|---|---|
| **1. El Mock Falso en Producción** | Reemplaza una llamada real a la base de datos o API por un dato estático inventado (`return { exito: true }`). | Parece que funciona en tu prueba, pero en producción no guarda nada. | **PROHIBIDO:** Cero datos ficticios o mocks en rutas de producción. |
| **2. El `try-catch` Silencioso** | Envuelve el código que falla en un bloque que atrapa el error pero lo ignora (`catch (e) { /* nada */ }`). | Oculta fallos críticos en lugar de arreglar la causa raíz. | **PROHIBIDO:** Todo error debe registrarse con contexto o propagarse. |
| **3. La Evasión de Tipos (`any` / `as unknown`)** | Cuando TypeScript marca un error de tipos, le pone `: any` o `// @ts-ignore`. | Destruye la seguridad del código y provoca caídas en tiempo de ejecución. | **PROHIBIDO:** Compilación con 0 errores y cero uso indiscriminado de `any`. |
| **4. La Reescribida Silenciosa** | Al pedir un ajuste de 3 líneas, borra 50 líneas de validaciones previas para simplificar el archivo. | Provoca regresiones masivas y rompe cosas que ya habías probado. | **PROHIBIDO:** Modificaciones atómicas respetando el código existente. |
| **5. La Alucinación de Paquetes** | Instala una librería externa para resolver un problema de 4 líneas que se resuelve con JavaScript nativo. | Engorda el proyecto innecesariamente y añade riesgos de seguridad. | **PROHIBIDO:** Cero dependencias nuevas sin autorización explícita. |
| **6. El Secreto Expuesto** | Escribe tu token o contraseña privada directamente en el archivo para que la prueba pase rápido. | Si subes el código a GitHub, tus credenciales son robadas en minutos. | **PROHIBIDO:** Cero secretos en código; uso estricto de variables de entorno `.env`. |

---

## 🔍 La Guía Práctica de Comprobación Humana en el Diff

Una lista de prohibiciones en texto ayuda, pero **la verdadera protección ocurre cuando tú inspeccionas el diff antes de aceptar los cambios**:

| Riesgo Típico en la Propuesta de la IA | Qué Comprobación Humana Debes Realizar | Comando / Acción Recomendada |
|---|---|---|
| **Cambia archivos no relacionados** | Verifica qué archivos tocó antes de abrir el código. | `git status -s` (Si tocó archivos ajenos a la tarea, pide revertirlos). |
| **Elimina funcionalidad existente** | Corre la suite de pruebas unitarias para detectar regresiones silenciosas. | `npm test` o `python -m pytest` |
| **Introduce dependencias innecesarias** | Revisa `package.json` o `requirements.txt`. | Comprueba si el paquete está actualizado, si tiene vulnerabilidades y si realmente es indispensable. |
| **Altera la estructura de la base de datos** | Revisa si el cambio rompe tablas o registros existentes en producción. | Exige una migración reversible en SQL antes de modificar modelos. |
| **Modifica permisos de acceso o RLS** | Comprueba que no haya abierto las tablas con políticas permisivas (`USING (true)`). | Ejecuta pruebas negativas (comprobar que un usuario sin sesión es rechazado). |
| **Añade lógica duplicada** | Busca si ya existía una función similar en la carpeta de utilidades. | Búsqueda global en el proyecto para reutilizar código en vez de duplicar. |
| **La IA afirma: "¡Todo funciona perfectamente!"** | **Desconfianza constructiva:** No le creas a su palabra; ejecuta tú mismo la comprobación. | Corre el Quality Gate y verifica el comportamiento relevante en el navegador. |
