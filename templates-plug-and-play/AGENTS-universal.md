# 🤖 Reglas Universales de Gobernanza para Agentes de IA (`AGENTS.md`)

> **Mandato Institucional Obligatorio para Cursor, Claude, Antigravity, Copilot y Asistentes IA**  
> **Ámbito:** Aplica automáticamente a todas las sesiones de desarrollo, depuración y refactorización de este repositorio.

---

## 🎯 1. Filosofía de Construcción y Principios No Negociables
1. **El Paso Cero Primero:** Lee el archivo `SPEC.md` antes de realizar cambios estructurales. Prohibido asumir flujos o inventar tablas no especificadas.
2. **Desarrollo Liviano y Respetuoso del Hardware:** Diseña soluciones nativas y eficientes. Prohibido sugerir herramientas que consuman memoria excesiva sin justificación técnica.
3. **Cero Complacencia Emocional:** Prohibido disculparse o prometer mejoras vacías. Si algo falla, diagnostica objetivamente la causa raíz (5-Whys) y propón la solución mínima necesaria.
4. **Respeto a la Integridad del Código:** Prohibido reescribir archivos enteros cuando solo se requiere editar una función puntual. Conserva la documentación y comentarios preexistentes.

---

## 🚫 2. Matriz Anti-Atajos del Asistente (Prohibiciones Estrictas)

| Atajo Detectado | Regla Inquebrantable |
|---|---|
| **Mocks en Producción** | PROHIBIDO simular respuestas falsas en rutas que deben conectar a la base de datos o APIs externas. |
| **`try-catch` Silenciosos** | PROHIBIDO envolver código en bloques vacíos que oculten errores. Todo fallo debe registrarse con contexto. |
| **Evasión de Tipos** | PROHIBIDO el uso de `any`, `as unknown` o directivas para ignorar el compilador. Compilación con 0 errores y 0 advertencias. |
| **Secretos Expuestos** | PROHIBIDO escribir credenciales, API keys o tokens en código rastreado por git. Todo secreto debe residir en variables de entorno `.env`. |
| **Dependencias Innecesarias**| PROHIBIDO instalar paquetes de `npm` o `pip` para resolver algoritmos sencillos que se resuelven con código nativo. |
| **Ocultar Datos con CSS** | PROHIBIDO usar `display: none` para "proteger" información privada. Los datos confidenciales jamás deben salir del backend. |

---

## 🔒 3. Triángulo de Seguridad y Resiliencia
1. **Seguridad Frontend:** Asume que todo código, variable y petición que llega al navegador es 100% público (Prueba F12). Nunca expongas `service_role_key` ni secretos privados en el cliente.
2. **Seguridad Backend:** Valida firmas criptográficas (HMAC) en todos los webhooks entrantes (Stripe, WhatsApp, etc.).
3. **Seguridad en BD:** Asegura que toda tabla tenga **Row Level Security (RLS)** activado y políticas de aislamiento multi-usuario.
4. **Idempotencia:** Verifica identificadores únicos de eventos antes de procesar para evitar cobros dobles o mensajes duplicados.

---

## 🚦 4. Quality Gate Obligatorio
Antes de dar por concluida cualquier tarea o afirmar que el código está listo:
```bash
# Para proyectos Node / TypeScript:
npm run quality-gate

# Para proyectos Python:
python scripts/quality_gate.py
```
Si el script reporta algún fallo, la tarea **NO ESTÁ TERMINADA**. Corrige la causa raíz hasta obtener 100% de verificaciones superadas.
