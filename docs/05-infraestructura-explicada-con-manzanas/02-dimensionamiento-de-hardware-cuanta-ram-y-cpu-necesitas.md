# ⚙️ Dimensionamiento de Hardware: ¿Cuánta RAM y CPU Necesitas?

> *"El software bien diseñado corre en una tostadora. El software mal diseñado hace llorar a un servidor de 64 gigabytes."*

---

## 💻 1. Para tu Computadora de Desarrollo (En Casa)

¿Qué necesitas realmente en tu escritorio para programar asistido por Inteligencia Artificial?

* **Gama Modesta (4GB – 8GB de RAM):**  
  - **Estrategia:** Desarrollo nativo sin Docker. Editor de código ligero (VS Code limpio o Cursor con plugins mínimos). Bases de datos en la nube gratuita (Supabase/Neon).  
  - **Capacidad:** Puedes construir el 100% de las aplicaciones web, bots y dashboards del mundo real.
* **Gama Media (16GB de RAM):**  
  - **Estrategia:** Puedes correr contenedores ligeros de Docker de forma puntual si es estrictamente necesario, junto con el navegador y herramientas de diseño.
* **Gama Alta (32GB+ de RAM):**  
  - Solo necesaria si compilas aplicaciones móviles nativas pesadas en Android Studio / Xcode al mismo tiempo, o si entrenas modelos locales con Ollama de más de 14B parámetros.

---

## ☁️ 2. Para tus Servidores de Producción (En Internet)

Uno de los errores más comunes es contratar servidores sobredimensionados por miedo a que "no aguanten":

### Guía de Servidores VPS en la Vida Real (Hetzner, DigitalOcean, OVH):

| Recursos del VPS | Costo Estimado | ¿Cuánto tráfico soporta realmente? | Casos de Uso Típicos |
|---|---|---|---|
| **1 vCPU / 2GB RAM** | $4 – $5 USD / mes | Hasta **100,000 – 300,000 visitas al mes** (o 10,000 mensajes diarios en un bot de WhatsApp bien optimizado en Node/Go). | Bots, APIs de SaaS en fase inicial, backend de reservas. |
| **2 vCPU / 4GB RAM** | $8 – $12 USD / mes | Hasta **1,000,000 visitas al mes** con base de datos PostgreSQL local bien indexada. | Plataformas de cursos activas, e-commerce mediano. |
| **4 vCPU / 8GB RAM** | $18 – $25 USD / mes | Cientos de peticiones por segundo concurrentes. | Sistemas transaccionales de alto volumen. |

---

## ⚡ Los 3 Factores que Realmente Matan el Rendimiento (No es la CPU)

1. **Falta de Índices en la Base de Datos:**  
   Si una tabla tiene 50,000 filas y buscas a un usuario por email sin haber creado un índice (`CREATE INDEX idx_email ON usuarios(email);`), el servidor tiene que leer el disco 50,000 veces en cada login. Un índice reduce ese tiempo de 200ms a 0.5ms.
2. **Fugas de Memoria en Bucles:**  
   Guardar variables globales en Node o Python que nunca se limpian y van acumulando memoria hasta que el servidor explota (OOM - Out of Memory).
3. **Peticiones Bloqueantes en el Event Loop:**  
   Hacer cálculos matemáticos pesados en el mismo hilo donde atiendes las peticiones web de tus usuarios.
