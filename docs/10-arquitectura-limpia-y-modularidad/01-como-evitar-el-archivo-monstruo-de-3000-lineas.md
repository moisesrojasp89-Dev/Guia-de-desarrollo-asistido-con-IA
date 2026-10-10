# 🦖 Cómo Evitar el "Archivo Monstruo" de 3,000 Líneas

> *"El archivo monstruo no nace de la noche a la mañana: nace cada vez que le dices a la IA 'agrega esta otra cosita aquí abajo' durante 3 semanas seguidas."*

---

## 🌋 El Nacimiento del Monolito Espagueti

El patrón es siempre el mismo:
1. El día 1 creas `server.js` o `app.py` con 40 líneas.
2. El día 3 la IA agrega las rutas de usuarios (+100 líneas).
3. El día 7 agrega la conexión con Stripe (+250 líneas).
4. El día 14 agrega validaciones, modelos de base de datos, plantillas HTML y funciones de utilidad (+1,200 líneas).
5. Para el día 21, tienes un archivo de **2,800 líneas** donde todo está entrelazado.

### ¿Por qué la IA adora crear archivos monstruo?
Porque para la IA es más fácil agregar 20 líneas al final de un archivo que ya tiene abierto que pensar en crear una carpeta nueva, importar módulos, exportar tipos y actualizar las rutas. **Es el atajo por excelencia del asistente de IA.**

---

## 🪓 La Regla del Hacha: Límite Estricto de 300 Líneas

En tu arnés de instrucciones (`AGENTS.md`), impón esta ley innegociable:

> **«Ningún archivo de código fuente debe superar las 300 – 400 líneas de longitud. Si un archivo se acerca a este límite, es obligatorio dividirlo en módulos desacoplados.»**

---

## 📁 Cómo Organizar una Carpeta Limpia y Escalable

Aplica el patrón de **Separación por Dominios o Responsabilidades**:

```text
src/
├── routes/              # Solo definen qué URLs existen (ej: /pedidos, /usuarios)
│   ├── pedidos.routes.ts
│   └── usuarios.routes.ts
├── controllers/         # Reciben la petición web y llaman al servicio
│   ├── pedidos.controller.ts
│   └── usuarios.controller.ts
├── services/            # La lógica de negocio pura (calcular totales, reglas)
│   ├── pedidos.service.ts
│   └── stripe.service.ts
├── database/            # Solo consultas directas a la base de datos
│   └── pedidos.repository.ts
└── utils/               # Funciones matemáticas puras (formatear fechas, centavos)
    └── currency.ts
```

Cuando cada archivo tiene entre 50 y 150 líneas:
- Puedes pedirle a la IA: *"Edita únicamente `currency.ts`"*.
- El modelo solo lee 50 líneas, responde en 1 segundo y tiene un **0% de probabilidad de romper la pasarela de pagos**.
