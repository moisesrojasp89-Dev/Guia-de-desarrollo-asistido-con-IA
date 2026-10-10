# 📖 Diccionario Dev para Todos: Conceptos Técnicos sin Enredos

> *"No hay conceptos difíciles en informática: solo ingenieros que los explican con palabras complicadas para sonar importantes."*

---

| Término | Analogía Cotidiana | ¿Qué es en la realidad? |
|---|---|---|
| **API** | **El camarero de un restaurante.** Tú no entras a la cocina a cocinar; le dices al camarero lo que quieres, él va a la cocina y te trae el plato listo. | Una puerta de comunicación estandarizada que permite que dos programas de software se envíen datos de forma segura. |
| **Backend** | **La cocina a puerta cerrada.** Donde se guardan las recetas secretas, se pican los ingredientes y se preparan los platos sin que los comensales vean el desorden. | Los servidores privados donde se ejecutan las reglas del negocio, los cobros y las consultas a bases de datos. |
| **Frontend** | **El comedor y las mesas del restaurante.** La decoración, el menú de papel, la música y la iluminación donde se sienta el cliente. | La pantalla visual (HTML, CSS y JavaScript) que se ejecuta en el navegador o teléfono del usuario. |
| **Base de Datos** | **Una cómoda con cajones etiquetados.** Si abres el cajón 'usuarios', solo encuentras nombres y correos; si abres 'pedidos', encuentras compras. | Un programa optimizado para guardar información organizada en el disco duro para que no se pierda al apagar el equipo. |
| **JWT (Token)** | **La pulsera de tela de un festival de música.** Te la ponen en la entrada tras pagar tu boleto; cuando vas a la barra por una bebida, solo muestras la pulsera y no tienes que volver a sacar tu tarjeta de crédito. | Una cadena de texto encriptada que tu navegador envía en cada petición para demostrar que ya iniciaste sesión. |
| **Webhook** | **El timbre de la puerta de tu casa.** En lugar de estar asomándote a la ventana cada 10 segundos para ver si llegó el cartero, te quedas leyendo en el sofá hasta que el cartero toca el timbre. | Una URL pública donde servicios externos (Stripe, WhatsApp) te avisan en el instante exacto en que ocurrió un evento. |
| **Idempotencia** | **El interruptor de encendido de la televisión.** Si presionas el botón de 'Encender' 10 veces seguidas, el televisor queda encendido una sola vez; no se rompe ni se enciende 10 veces. | Una propiedad matemática donde repetir la misma operación varias veces produce exactamente el mismo resultado seguro. |
| **Mock** | **Un actor doble de riesgo.** En las escenas de explosiones de una película, no pones en riesgo al actor principal; usas un muñeco o un doble entrenado. | Una función simulada en memoria que finge ser una API externa (como Stripe) durante las pruebas automáticas para no gastar dinero ni depender de internet. |
| **Transacción (ACID)** | **El intercambio mano a mano.** «Tú me das el libro y yo te doy el billete al mismo tiempo». Si tú sueltas el libro pero yo me guardo el billete, se cancela todo de inmediato. | Un bloque de operaciones en base de datos donde o se guardan todos los cambios con éxito, o se deshace todo (*Rollback*). |
| **RLS (Row Level Security)** | **La tarjeta magnética de un hotel.** Abre la puerta de tu habitación (la 302), pero si intentas pasarla por la puerta de la 304 o la administración, la cerradura permanece cerrada. | Reglas de seguridad automáticas en PostgreSQL que impiden que un usuario lea o modifique datos pertenecientes a otros. |
| **Rate Limiting** | **El portero de la discoteca.** Solo deja pasar a 10 personas por minuto para que nadie quede aplastado en la pista de baile. | Un límite técnico que restringe cuántas peticiones puede hacer una misma dirección IP para evitar caídas por spam. |
| **Quality Gate** | **El control de seguridad del aeropuerto.** Antes de subir al avión, revisan tu maleta con rayos X; si llevas tijeras o líquidos prohibidos, no te dejan pasar. | Un script automático que revisa que tu código no tenga errores de sintaxis, pruebas rotas ni claves secretas expuestas antes de subirlo a producción. |
