# 📋 ESPECIFICACIÓN DEL PROYECTO (SPEC.md) - [NOMBRE DE TU PROYECTO]

> **Instrucciones de Uso:**  
> Rellena este documento antes de tocar la primera línea de código y entrégaselo a tu asistente de IA.  
> Recuerda la regla de oro: *"Si tú no tienes claro el mapa en la servilleta, la IA inventará un laberinto"*.

---

## 🎯 1. El Problema y la Solución (MVP)

* **¿Qué problema real resuelve?**  
  *(Describe en 1 o 2 oraciones qué dolor de cabeza alivia tu aplicación y para quién).*  
  *Ejemplo: "Permite a entrenadores personales enviar rutinas semanales por WhatsApp y cobrar su mensualidad por Stripe sin gestionar planillas de cálculo manuales."*

* **La Solución MVP (Producto Mínimo Viable):**  
  *(¿Qué es lo mínimo indispensable que debe funcionar para que un usuario pueda usarlo hoy?)*

* **🚫 ANTI-SCOPE (Estrictamente Prohibido en esta versión):**  
  *(La lista de cosas que NO construiremos por ahora para no desbordar el proyecto. Obligatorio para frenar a la IA).*
  - [ ] No habrá chat en tiempo real complejo (solo mensajes básicos o WhatsApp).
  - [ ] No habrá soporte multi-idioma (solo un idioma principal).
  - [ ] No habrá pasarelas de pago múltiples (solo una: ej. Stripe).
  - [ ] No habrá aplicación móvil nativa (solo web responsive para navegador).

---

## 🚶‍♂️ 2. El Viaje del Usuario (El Flujo Principal)

Escribe el camino paso a paso que recorre el usuario:

```text
Paso 1: [Dónde inicia el usuario, ej: Aterriza en la página web]
Paso 2: [Qué acción realiza, ej: Elige su plan y llena su nombre y email]
Paso 3: [Bifurcación, ej: ¿El pago fue exitoso?]
        ├── Sí: [Va a pantalla de bienvenida y recibe su enlace de acceso]
        └── No: [Muestra mensaje de error amigable y botón de reintentar]
Paso 4: [Punto final de éxito]
```

---

## 🗄️ 3. El Mapa de Datos Esencial (Las Tablas Mínimas)

Define únicamente los datos que son indispensables para el flujo:

### Tabla 1: `usuarios`
- `id` (Identificador único, UUID o texto)
- `email` (Texto único)
- `nombre` (Texto)
- `creado_en` (Fecha y hora automática)

### Tabla 2: `[tu_segunda_entidad, ej: productos / rutinas / citas]`
- `id` (Identificador único)
- `titulo` (Texto)
- `precio_centavos` (Número entero, ej: 2500 para $25.00)
- `activo` (Verdadero / Falso)

### Tabla 3: `[tu_tercera_entidad, ej: pagos / reservas / inscripciones]`
- `id` (Identificador único)
- `usuario_id` (Relación a tabla usuarios)
- `estado` ('pendiente' / 'completado' / 'fallido')
- `monto_centavos` (Número entero)
- `actualizado_en` (Fecha y hora)

---

## 🏗️ 4. Arquitectura en Servilleta (¿Quién habla con quién?)

* **Frontend (Pantalla):**  
  *(Ejemplo: HTML, CSS y JavaScript Vanilla con Vite / React ligero).*
* **Backend y Base de Datos:**  
  *(Ejemplo: Supabase PostgreSQL con Row Level Security activado).*
* **Servicios Externos:**  
  *(Ejemplo: Stripe Checkout para pagos con Webhook hacia el backend).*

---

## 📋 5. Mandatos Inquebrantables para el Asistente de IA

1. Respeta estrictamente los nombres de campos y tablas definidos en la Sección 3.
2. Si una tarea requiere algo fuera del alcance (Anti-Scope), detente y consulta antes de implementar.
3. No instales dependencias externas pesadas sin aprobación explícita.
4. Diseña una interfaz limpia, accesible y optimizada para dispositivos móviles (Mobile-First).
