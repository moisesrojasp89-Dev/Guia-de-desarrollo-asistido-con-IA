# 🚦 Semáforo de Riesgo de Código Generado por IA

> *"No todo el código generado por IA requiere la misma atención. Usa este semáforo para saber dónde puedes confiar rápido y dónde debes revisar con lupa de joyero."*

---

## 🔴 ZONA ROJA: Revisar con Lupa de Joyero (Riesgo Crítico)

| Componente | Qué suele hacer mal la IA | Qué debes verificar tú personalmente |
|---|---|---|
| **Cobros y Pagos** | Confiar en que el pago pasó sin verificar la respuesta de la pasarela. | Que el cobro se registre **únicamente** tras validar el webhook oficial de Stripe o PayPal. |
| **Recepción de Webhooks** | Procesar el payload directamente sin validar firmas ni deduplicar. | Validar la firma criptográfica **HMAC** y comprobar **idempotencia** (`event_id` único). |
| **Políticas de Base de Datos (RLS)**| Crear políticas de `USING (true)` que dejan las tablas abiertas a todo el mundo. | Probar que un usuario con ID 'A' reciba un error al intentar leer datos del usuario 'B'. |
| **Manejo de Credenciales** | Dejar tokens o claves privadas hardcodeadas en el código. | Que todo secreto provenga de `process.env` o `os.environ` y que `.env` esté en `.gitignore`. |
| **Borrado de Datos (DELETE / DROP)**| Ejecutar sentencias destructivas sin cláusula `WHERE` o sin confirmación. | Confirmar que el borrado esté restringido por usuario y con confirmación en dos pasos. |

---

## 🟡 ZONA AMARILLA: Verificación de Lógica (Riesgo Medio)

| Componente | Qué suele hacer mal la IA | Qué debes verificar tú personalmente |
|---|---|---|
| **Estados de la Interfaz (UI)** | Programar solo el caso de éxito (*Happy Path*). | Comprobar qué ve el usuario si la lista está vacía (*Empty*) o si se corta la conexión (*Error*). |
| **Formularios e Inputs** | No sanitizar texto o permitir números negativos en precios. | Que los campos numéricos sean enteros positivos en centavos y con límites máximos. |
| **Transiciones de Estado** | Permitir saltos ilógicos (ej. marcar 'Entregado' sin haber pasado por 'Pagado'). | Forzar máquinas de estado que impidan transiciones inválidas. |
| **Nuevas Dependencias** | Instalar paquetes pesados de `npm` o `pip` para tareas simples. | Preguntarte: *«¿Realmente necesitamos esta librería o se resuelve con 5 líneas de código?»*. |

---

## 🟢 ZONA VERDE: Confianza Rápida (Bajo Riesgo)

| Componente | Por qué es seguro | Cómo verificarlo |
|---|---|---|
| **Estructura HTML Semántica** | La IA es excelente organizando etiquetas `<header>`, `<main>`, `<footer>`. | Inspeccionar visualmente que la jerarquía sea ordenada. |
| **Estilos CSS con Tokens** | Generar animaciones suaves, flexbox, grid y márgenes. | Mirar la pantalla en el navegador y probar en modo móvil. |
| **Generación de Mocks y Datos Dummy** | Inventar nombres, correos y listas para pruebas unitarias. | Ejecutar el runner de tests (`npm test`). |
| **Comentarios y Documentación** | Explicar funciones existentes o redactar guías de usuario. | Lectura rápida de claridad y coherencia. |
