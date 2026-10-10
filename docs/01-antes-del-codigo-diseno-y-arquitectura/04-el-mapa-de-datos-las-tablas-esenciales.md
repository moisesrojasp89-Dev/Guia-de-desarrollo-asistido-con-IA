# 🗄️ El Mapa de Datos: Las Tablas Esenciales

> *"Una base de datos no es más que una cómoda con cajones etiquetados. Si mezclas las medias con los cubiertos de cocina, nunca encontrarás nada."*

---

## 🗃️ El Síndrome de la "Tabla Monstruo"

Uno de los errores más destructivos que comete la IA cuando no le das límites es crear una sola tabla gigantesca llamada `datos` o `registros` donde guarda todo apretado: el nombre del usuario, su contraseña, los productos que compró, el mensaje que envió y la dirección de su abuela.

Al poco tiempo, cuando necesitas saber cuántos productos compró un cliente en particular, la consulta se vuelve imposible y lenta.

---

## 🏷️ Cómo Diseñar tu Cómoda de Datos en 3 Pasos

Para cualquier aplicación, solo necesitas identificar los **Sustantivos Principales** de tu negocio.

### Paso 1: Identifica tus Sustantivos (Las Entidades)
Pregúntate: *¿Cuáles son las cosas o personas reales que existen en mi sistema?*
- Si es una clínica: Pacientes, Médicos, Citas.
- Si es una tienda: Clientes, Productos, Pedidos.
- Si es un blog o cursos: Usuarios, Artículos, Comentarios.

### Paso 2: Define qué etiqueta lleva cada cajón
No agregues 30 campos "por si acaso". Agrega solo lo estrictamente necesario para que el MVP funcione:

#### Ejemplo de Tienda:
```text
Cajón 1: usuarios
├── id (código único, ej: usr_123)
├── email (juan@correo.com)
├── nombre ("Juan Pérez")
└── creado_en (fecha y hora)

Cajón 2: productos
├── id (código único, ej: prod_01)
├── titulo ("Café Colombiano 500g")
├── precio_centavos (1500 -> significa $15.00)
└── stock_disponible (25)

Cajón 3: pedidos
├── id (código único, ej: ord_999)
├── usuario_id (apunta al id del usuario que compró)
├── producto_id (apunta al producto comprado)
├── monto_total (1500)
├── estado ('pendiente', 'pagado', 'cancelado')
└── pagado_en (fecha y hora)
```

### Paso 3: Define cómo se conectan (Las Relaciones)
Mira el Cajón 3 (`pedidos`): tiene un campo llamado `usuario_id` que apunta al `id` del cliente en el Cajón 1.
Eso es una **Relación**:
- Un usuario puede tener **muchos pedidos**.
- Pero cada pedido pertenece a **un solo usuario**.

---

## 💎 3 Reglas de Oro para Datos Sanos

1. **Guarda el dinero en números enteros (Centavos):**  
   Nunca guardes precios como decimales flotantes (`15.99`), porque las computadoras tienen imprecisiones al calcular decimales (`0.1 + 0.2 = 0.30000000000000004`). Guarda siempre en centavos (`1599`) y divide entre 100 solo al pintar en pantalla.
2. **Nombres en minúsculas y sin espacios:**  
   Usa siempre formato serpiente (`usuario_id`, `fecha_creacion`). Evita mezclar mayúsculas como `UsuarioID` o `FechaCreacion` que provocan errores entre diferentes sistemas operativos.
3. **Cero campos duplicados:**  
   Si ya guardaste el email del cliente en la tabla `usuarios`, no vuelvas a crear una columna de email en la tabla `pedidos`. Usa el `usuario_id` para enlazarlo.
