# 📡 Cómo Viajan los Datos por Internet: HTTP y WebSockets

> *"Internet no es magia inalámbrica: son mensajes de texto estructurados que van y vienen a la velocidad de la luz entre dos computadoras."*

---

## 📬 1. El Protocolo HTTP: La Carta con Sobre y Remitente

Cuando tu navegador necesita información de un servidor (o cuando envías un formulario), utiliza **HTTP** (o su versión segura y encriptada, **HTTPS**).

La mejor forma de entender HTTP es imaginar una **carta formal por correo**:

```text
┌──────────────────────────────────────────────────────────────┐
│  EL SOBRE (Cabeceras / Headers):                             │
│  • De: Navegador Chrome (v124) en Windows                     │
│  • Para: https://api.mifarmacia.com/medicamentos             │
│  • Formato: "Hablo español y quiero datos en formato JSON"   │
│  • Credencial: "Llevo este token de usuario autorizado"      │
├──────────────────────────────────────────────────────────────┤
│  EL MENSAJE ADENTRO (El Cuerpo / Body):                      │
│  {                                                           │
│    "nombre": "Aspirina",                                     │
│    "cantidad": 2                                             │
│  }                                                           │
└──────────────────────────────────────────────────────────────┘
```

---

### Los 4 Verbos Básicos de HTTP
Cada carta lleva un sello con la acción que quieres realizar:
1. **GET (Traer):** *«Por favor, léeme el catálogo de productos»* (No envías nada en el cuerpo, solo pides datos).
2. **POST (Crear / Enviar):** *«Por favor, guarda esta nueva orden en tu sistema»*.
3. **PUT / PATCH (Modificar):** *«Por favor, actualiza el número de teléfono de este usuario»*.
4. **DELETE (Borrar):** *«Por favor, elimina este producto de mi carrito»*.

---

### Los Códigos de Respuesta (El Semáforo)
Cuando el servidor te responde, te devuelve un código numérico universal de 3 dígitos:
* **200 (Éxito):** Todo salió perfecto.
* **400 (Petición Errónea):** Me enviaste datos incompletos (ej. olvidaste escribir el email).
* **401 / 403 (Prohibido):** No has iniciado sesión o no tienes permiso para ver esto.
* **404 (No Encontrado):** Lo que estás buscando no existe en este servidor.
* **500 (Explosión en la Cocina):** Error interno del servidor; el código del backend falló.

---

## 📞 2. WebSockets (WSS): La Llamada Telefónica Abierta

Con HTTP, cada vez que quieres saber algo, tienes que enviar una nueva carta y esperar la respuesta:
- *«¿Hay mensajes nuevos?»* -> *«No»*.
- *«¿Y ahora?»* -> *«No»*.
- *«¿Y ahora?»* -> *«Sí, aquí tienes uno»*.  
(Esto se llama *Polling* y gasta recursos a lo tonto).

**WebSockets (WS o WSS)** es radicalmente diferente:
- Es como **marcar un número de teléfono y dejar la llamada abierta**.
- Una vez conectados, ni el cliente ni el servidor tienen que volver a enviar cartas.
- En cuanto ocurre un evento (un mensaje nuevo de WhatsApp, un gol en un partido en vivo, o una actualización de precio de una acción), el servidor habla por el auricular instantáneamente: **latencia en milisegundos**.

### ¿Cuándo usar cada uno?
- **Usa HTTP:** Para el 90% de las cosas normales (iniciar sesión, registrarse, comprar un producto, cargar una página).
- **Usa WebSockets:** Solo para funciones en tiempo real donde cada segundo cuenta (chats en vivo, tableros de trading en directo, juegos multijugador).
