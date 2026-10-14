# 🔔 ¿Qué es un Webhook? La Analogía del Timbre de tu Casa

> *"En lugar de asomarte a la ventana cada 10 segundos a ver si llegó el cartero, pon un timbre en la puerta y deja que el cartero te avise."*

---

## 🚪 El Dilema: Polling vs. Webhook

Imagina que estás esperando un paquete urgente de una tienda online:

### Método A: Polling (Asomarse a la ventana)
- Te levantas cada 30 segundos, abres la puerta y miras la calle: *«¿Llegó? No»*.
- Te vuelves a sentar.
- A los 30 segundos te vuelves a levantar: *«¿Llegó? No»*.
- Haces esto 500 veces al día.
- **Resultado:** Terminas agotado, desgastas la cerradura y la mayor parte del tiempo no obtienes nada nuevo.

### Método B: Webhook (El Timbre de la Casa)
- Te sientas cómodamente en el sofá a leer un libro.
- Le dices al cartero: *«Cuando llegues, toca este timbre»*.
- En el instante exacto en que llega el paquete, **ding-dong**.
- Te levantas solo una vez, recoges la caja y sigues con tu vida.

---

## 📦 En el Software: ¿Cómo se ve un Webhook?

Un **Webhook** es simplemente una dirección URL que tú le proporcionas a un servicio externo (como Stripe, PayPal, WhatsApp/Meta, Shopify o GitHub):

```text
https://mi-empresa.com/api/webhooks/pagos
```

Cuando ocurre algo en su plataforma:
1. Un cliente pagó una suscripción en Stripe.
2. Un usuario envió un mensaje de WhatsApp a tu número de negocio.
3. Un cliente completó una orden en Shopify.

El servicio externo empaqueta la información en un formato JSON y hace una petición **POST HTTP** directamente a tu timbre (tu URL). Tu servidor recibe los datos en menos de 100 milisegundos y procesa el pedido al instante.
