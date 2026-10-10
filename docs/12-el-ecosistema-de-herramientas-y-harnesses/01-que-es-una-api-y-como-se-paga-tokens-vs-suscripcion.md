# 💳 ¿Qué es una API y Cómo se Paga? Tokens vs. Suscripción Mensual

> *"El error #1 de quien empieza con IA es creer que pagar ChatGPT Plus o Claude Pro por \$20 dólares al mes le da acceso a las APIs para programar."*

---

## 🔌 1. ¿Qué es realmente una API?

Imagina un restaurante exclusivo:
* **El Chat Web (ChatGPT / Claude.ai):** Es la mesa del restaurante. Tú te sientas como cliente, te traen un menú cerrado y disfrutas de la comida con un camarero amable.
* **La API (Application Programming Interface):** Es la **puerta de proveedores de la cocina**. Tú no vas como comensal a sentarte; conectas un camión de suministros directamente a la cocina mediante un tubo automatizado.

Técnicamente:  
Una **API** es una dirección en internet donde tu propio código (tu aplicación web, tu bot o tu editor de código) envía texto en formato JSON y recibe texto generado por el modelo de IA en milisegundos, sin interfaces visuales ni botones de chat.

---

## 💸 2. El Gran Malentendido: Suscripción ($20/mes) vs. API (Pago por Uso)

Este es el concepto que más confunde a los principiantes:

| Concepto | Suscripción Web ($20 USD / mes) | API de Desarrollador (Pago por Uso) |
|---|---|---|
| **¿Qué es?** | ChatGPT Plus, Claude Pro, Gemini Advanced. | OpenAI API, Anthropic API, Google AI Studio. |
| **¿Cómo se paga?** | Tarifa plana fija mensual ($20 USD). | **Pago por consumo exacto de tokens** (prepago o pospago). |
| **¿Dónde se usa?** | En la página web o app oficial del proveedor. | En tu código, en Cursor, en scripts, bots o terminal. |
| **¿Si no lo usas un mes?** | Te cobran los \$20 USD de todos modos. | Pagas **\$0.00 USD**. |
| **¿Límites de uso?** | Límites de mensajes por hora (ej. "vuelve en 3 horas"). | Pagas lo que usas sin bloqueos por horas (sujeto a rate-limits por minuto). |

> [!WARNING]
> Tu cuenta de ChatGPT Plus **NO** te entrega una API Key para programar. Para usar la API necesitas una cuenta en la plataforma de desarrolladores (ej. `platform.openai.com` o `console.anthropic.com`) y recargar saldo con tarjeta (por ejemplo, \$5 o \$10 USD).

---

## 🔤 3. ¿Qué es un "Token"?

Los modelos de Inteligencia Artificial no leen letras sueltas ni palabras completas: leen **trozos de sílabas llamados tokens**.

* Como regla general rápida:  
  **1 token ≈ 4 caracteres de texto** (aproximadamente $0.75$ palabras en inglés, o unas $0.5$ palabras en español con tildes).
* Por ejemplo, la frase:  
  *«Hola, ¿cómo estás hoy?»* son aproximadamente **7 tokens**.
* Una página de un libro en texto plano contiene unos **500 a 700 tokens**.

---

## 📥 Tokens de Entrada (Input) vs. 📤 Tokens de Salida (Output)

Cuando usas una API, los precios siempre están divididos en dos columnas por cada millón de tokens (1M):

1. **Tokens de Entrada (Prompt / Contexto):**  
   Todo lo que tú le envías al modelo: tus instrucciones, el archivo `SPEC.md`, tu código actual y el historial.  
   *(Suele ser mucho más económico, por ejemplo \$0.15 a \$3.00 USD por millón).*
2. **Tokens de Salida (Generación / Completion):**  
   Todo lo que el modelo escribe de vuelta como respuesta o código generado.  
   *(Suele ser entre 3x y 5x más costoso porque requiere procesamiento activo de cálculo).*

---

## 🛡️ Cómo Proteger tu Bolsillo: El Límite de Gasto (Hard Limit)

Antes de conectar tu primera API Key a cualquier proyecto:
1. Ve a la sección de **Billing / Facturación** de tu proveedor (OpenAI, Anthropic, OpenRouter).
2. Configura un **Hard Limit (Límite estricto mensual)** de **\$5 o \$10 USD**.
3. Si por error cometes un bucle infinito en tu código que envíe 10,000 peticiones seguidas, la API cortará el servicio al llegar a \$5 USD, **garantizando que nunca te llegue una factura sorpresa de cientos de dólares**.
