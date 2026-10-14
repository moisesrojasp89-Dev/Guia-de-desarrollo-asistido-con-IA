# 🤖 Arnés Base de Gobernanza para Agentes de IA (`AGENTS.md`)
### Modelo de Referencia Evolutivo para Adaptar a tu Proyecto

> [!NOTE]
> **⚠️ ESTE ARCHIVO ES UN PUNTO DE PARTIDA, NO UNA VERDAD ABSOLUTA**  
> No existe un conjunto de reglas universales que aplique mágicamente a todos los tipos de software. Una aplicación fintech con pagos requiere restricciones de seguridad que sobrarían en un script de automatización o en un videojuego indie.  
> 
> **Trata este archivo como un documento vivo (*Living Document*):**  
> 1. Adopta los guardrails fundamentales de sentido común.  
> 2. Elimina las secciones que no apliquen a tu stack tecnológico.  
> 3. Conforme desarrolles y descubras atajos o errores recurrentes en tu asistente de IA, **agrega tus propias reglas específicas**.

---

## 🟢 Bloque 1: Guardrails Mínimos Universales (Sentido Común y Seguridad)
*Estas reglas aplican prácticamente a cualquier proyecto para evitar degradación de código y riesgos de seguridad:*

1. **El Paso Cero Primero:** Lee la documentación esencial del proyecto (o `SPEC.md`) antes de realizar cambios estructurales. Prohibido asumir flujos o inventar tablas/modelos no definidos.
2. **Respeto a la Integridad del Código:** Edita únicamente las funciones y líneas estrictamente necesarias. Prohibido reescribir archivos completos de 500 líneas para modificar una sola función. Conserva siempre los comentarios y la documentación preexistente.
3. **Cero Secretos Expuestos:** Prohibido escribir contraseñas, claves privadas, tokens o API keys directamente en el código rastreado por Git. Todo secreto debe residir en variables de entorno (`.env`).
4. **Cero `try-catch` Silenciosos:** Prohibido envolver código en bloques vacíos que oculten excepciones. Todo error debe registrarse con contexto suficiente para depuración.
5. **No inventar dependencias sin justificación:** Prohibido instalar librerías pesadas o paquetes externos de `npm` o `pip` para resolver algoritmos elementales que se resuelven con funciones nativas.
6. **Cero Mocks en Producción:** Prohibido dejar datos falsos (*hardcoded mocks*) en servicios que deben conectarse a bases de datos o APIs reales sin advertirlo de forma explícita.

---

## 🟡 Bloque 2: Reglas Adaptables según tu Stack Tecnológico
*Modifica, reemplaza o elimina estas reglas según las tecnologías y herramientas que uses en tu proyecto:*

### Si usas TypeScript / JavaScript:
* **Tipado Estricto:** Evita el uso indiscriminado de `any` o `as unknown`. Si una librería externa carece de tipos, define interfaces mínimas en un archivo `.d.ts`.
* **Seguridad en Frontend (F12):** Asume que todo dato que viaja al navegador es público. Nunca expongas claves maestras (`service_role_key`) en el cliente ni intentes ocultar datos confidenciales usando `display: none` en CSS.

### Si usas Python:
* **Tipado y PEP 8:** Usa type hints (`typing`) en firmas de funciones públicas y sigue las convenciones de nombres estándar.
* **Manejo de Entornos:** Prohibido instalar paquetes globales; utiliza siempre un entorno virtual (`venv` o `poetry`).

### Resiliencia de Datos (Si tu app maneja dinero o webhooks):
* **Firmas Criptográficas (HMAC):** Todo webhook entrante (Stripe, Meta/WhatsApp, Shopify) debe verificar su firma antes de parsear el cuerpo de la petición.
* **Idempotencia:** Verifica identificadores únicos de eventos antes de procesar transacciones para prevenir cobros dobles o mensajes duplicados ante reintentos de red.

---

## 🚦 Bloque 3: Quality Gate Obligatorio (Tu Compuerta de Aprobación)
*Define aquí el comando exacto que tu asistente debe ejecutar y superar antes de decirte "listo":*

```bash
# Ejemplo para Node / TypeScript:
npm run quality-gate   # O npm test && tsc --noEmit

# Ejemplo para Python:
python scripts/quality_gate.py   # O pytest && flake8
```

> **Mandato para el Asistente:** Si el comando de verificación reporta algún fallo o advertencia crítica, la tarea **NO ESTÁ TERMINADA**. Corrige la causa raíz hasta obtener 100% de verificaciones aprobadas.

---

## 🔵 Bloque 4: Reglas Específicas de tu Proyecto (Tu Bitácora de Aprendizaje)
*Este es tu espacio personal. A medida que tu asistente cometa errores específicos de tu negocio o de tus preferencias personales, escríbelos aquí:*

* *[Ejemplo]: En este proyecto usamos Tailwind CSS, prohibido escribir estilos CSS inline en los componentes.*
* *[Ejemplo]: Para el estado global usamos Zustand; prohibido sugerir Redux o Context API para flujos simples.*
* *[Ejemplo]: Todas las fechas deben guardarse en formato UTC en la base de datos.*
