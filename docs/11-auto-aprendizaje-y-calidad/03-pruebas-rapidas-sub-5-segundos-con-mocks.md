# ⚡ Pruebas Rápidas Sub-5 Segundos con Mocks Deterministas

> *"Si tu suite de pruebas tarda 3 minutos en ejecutarse, no la vas a correr. Si tarda 2 segundos, la vas a correr después de cada tecla que toques."*

---

## 🐢 La Paradoja de las Pruebas Lentas

La mayoría de los cursos de programación enseñan a hacer pruebas haciendo peticiones reales por internet:
- Levantan un navegador falso (Selenium o Puppeteer).
- Crean una cuenta real de prueba.
- Esperan 5 segundos a que cargue la página.
- Envían un correo real.

Una suite de 20 pruebas de este tipo tarda **4 minutos**.  
En el desarrollo con IA, esto es inviable: necesitas iterar rápido. Si tienes que esperar 4 minutos tras cada sugerencia de la IA, el flujo de concentración se destruye por completo.

---

## 🎭 El Secreto: Mocks Deterministas en Memoria

Un **Mock** es un doble de riesgo cinematográfico:
- En lugar de disparar una bala real, dispara una bala de fogueo.
- En lugar de llamar a los servidores de Stripe o de OpenAI a través de internet, interceptas la función y le devuelves una respuesta simulada instantánea guardada en memoria:

```typescript
// Ejemplo de prueba instantánea con Vitest:
import { describe, it, expect, vi } from 'vitest';
import { cobrarUsuario } from '../src/servicios/pagos';

describe('Flujo de Cobro Seguro', () => {
  it('debe registrar la orden cuando el cobro es exitoso', async () => {
    // Simulamos la respuesta de Stripe en 0 milisegundos:
    const mockStripe = {
      cobrar: vi.fn().mockResolvedValue({ id: 'ch_test_123', status: 'succeeded' })
    };

    const resultado = await cobrarUsuario('usr_99', 1500, mockStripe);

    expect(resultado.exito).toBe(true);
    expect(resultado.transaccionId).toBe('ch_test_123');
    expect(mockStripe.cobrar).toHaveBeenCalledTimes(1);
  });
});
```

---

## ⏱️ El Presupuesto de Velocidad: < 5 Segundos
- Toda la suite de pruebas unitarias debe correr en **menos de 5 segundos**.
- Se ejecuta 100% desconectada de internet (*offline*).
- Puedes correrla en un avión, en una cafetería o en una laptop con 4GB de RAM sin depender de conexiones externas.
