# 📄 Cómo Redactar tu Primer SPEC.md

> *"El archivo SPEC.md es el contrato inquebrantable entre tu visión y la ejecución de la Inteligencia Artificial."*

---

## 🎯 ¿Qué es un `SPEC.md`?

`SPEC.md` (abreviatura de *Specification Document* o Documento de Especificación) es un archivo en formato Markdown que colocas en la raíz de tu proyecto **antes de escribir la primera línea de código**.

Es el documento donde unes los 4 pasos previos:
1. El Problema & MVP (con su lista de qué NO construir).
2. El Diagrama de Flujo del Usuario.
3. El Mapa de Datos Esencial.
4. La Arquitectura en Servilleta.

---

## 🏗️ La Estructura de un `SPEC.md` Perfecto

Un buen `SPEC.md` no necesita tener 50 páginas. Un documento de **1 a 2 páginas** estructurado de la siguiente forma es suficiente para guiar a cualquier asistente de IA con precisión quirúrgica:

```markdown
# 📌 ESPECIFICACIÓN TÉCNICA (SPEC.md) - [Nombre de tu Proyecto]

## 1. El Problema y la Solución (MVP)
- **Problema real:** Los clientes de mi cafetería hacen fila de 20 minutos en la mañana para pedir su café para llevar.
- **Solución MVP:** Una página web simple donde el cliente elige su café, paga por internet y recibe una hora estimada para retirar su pedido en el mostrador.
- **🚫 ANTI-SCOPE (Lo que NO construiremos en esta versión):**
  - No habrá sistema de propinas complejas.
  - No habrá calificaciones ni reseñas de clientes.
  - No habrá aplicación nativa para iPhone o Android (solo web móvil).
  - No habrá múltiples idiomas (solo español).

---

## 2. El Viaje del Usuario (Flujo Principal)
1. El usuario entra a la web y ve la lista de 4 tipos de café.
2. Selecciona su bebida y presiona "Pagar ahora".
3. Ingresa su Nombre y Teléfono.
4. Completa el pago en Stripe Checkout.
5. Recibe una pantalla verde con su número de orden: #ORD-101.

---

## 3. Modelo de Datos Mínimo
- `usuarios`: id, nombre, telefono, creado_en.
- `productos`: id, nombre, precio_centavos, disponible (true/false).
- `pedidos`: id, usuario_id, producto_id, estado ('pagado' / 'preparando' / 'entregado'), creado_en.

---

## 4. Arquitectura Técnica
- **Frontend:** HTML, CSS y Vanilla JS (o Vite + React ligero), responsive para celular.
- **Backend / Base de datos:** Supabase (PostgreSQL) con autenticación sencilla y RLS activado.
- **Cobros:** Stripe Checkout vía Webhook.
```

---

## 🪄 El Prompt Inicial para Entregar tu `SPEC.md`

Una vez que tengas tu archivo `SPEC.md` guardado en tu carpeta de proyecto, abre el chat de tu IA y escribe este prompt:

```text
Hola. He redactado el archivo SPEC.md en la raíz de este proyecto. 
Léelo con total atención. 

Tu misión en este momento NO es generar código todavía. 
Quiero que hagas lo siguiente:
1. Resume en tus propias palabras cuál es el objetivo del MVP y qué cosas están explícitamente fuera de alcance (Anti-Scope).
2. Confirma si encuentras alguna inconsistencia técnica entre el flujo de usuario y el modelo de datos.
3. Propón únicamente la estructura de carpetas y archivos vacíos que necesitaremos para implementar este SPEC.

Espera mi visto bueno antes de crear o editar cualquier archivo.
```

Al hacer esto, **tú tienes el control total**. La IA demostrará si realmente comprendió tus reglas y respetará tu visión de principio a fin.
