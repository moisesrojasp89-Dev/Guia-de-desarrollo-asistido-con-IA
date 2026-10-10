# 🧼 Pureza de Importación: Cero Efectos Colaterales (Zero Side-Effects)

> *"Importar un archivo para usar una función matemática no debería encender un servidor web ni conectarse a una base de datos en secreto."*

---

## 💣 El Peligro del Efecto Colateral al Importar

Imagina este archivo:

```javascript
// ❌ ARCHIVO CON EFECTO COLATERAL (Mala práctica común de IA)
import { createClient } from '@supabase/supabase-js';

// ¡ALERTA! Este código se ejecuta en el instante en que alguien hace "import" de este archivo:
console.log("Conectando a la base de datos...");
export const db = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);

export function formatearMoneda(centavos) {
  return `$${(centavos / 100).toFixed(2)}`;
}
```

### ¿Por qué esto es una trampa mortal?
Si quieres hacer una prueba unitaria sencilla de la función `formatearMoneda(1500)`:
1. Escribes `import { formatearMoneda } from './utils.js'`.
2. Tu test intenta conectarse inmediatamente a Supabase por internet.
3. Si estás sin conexión o si las variables de entorno de producción no están en tu máquina de tests, **la prueba explota con un error**.
4. Tus pruebas unitarias se vuelven lentas, frágiles y dependientes de la red.

---

## 💎 El Principio de Pureza de Importación

Un archivo de código debe ser **puro**:  
**El acto de importar un módulo jamás debe ejecutar acciones en el mundo real.**

```javascript
// ✅ ARCHIVO PURO Y MODULAR (Buena práctica)
import { createClient } from '@supabase/supabase-js';

// La conexión se envuelve en una función que solo se llama cuando sea explícitamente necesario:
let clienteDb = null;

export function obtenerClienteDb() {
  if (!clienteDb) {
    clienteDb = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);
  }
  return clienteDb;
}

export function formatearMoneda(centavos) {
  return `$${(centavos / 100).toFixed(2)}`;
}
```

Ahora puedes probar `formatearMoneda` 10,000 veces en 50 milisegundos sin tocar internet ni levantar bases de datos.
