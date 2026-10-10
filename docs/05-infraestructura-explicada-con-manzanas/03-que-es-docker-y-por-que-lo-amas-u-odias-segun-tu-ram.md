# 🐳 ¿Qué es Docker y por qué lo Amas u Odias según tu RAM?

> *"Docker es la solución maravillosa al famoso 'en mi máquina sí funcionaba'. Pero si tu máquina tiene poca RAM, Docker puede convertirse en tu peor pesadilla."*

---

## 🚢 La Analogía del Contenedor Marítimo

Antes de que existieran los contenedores de carga universales (esos grandes rectángulos metálicos de los barcos), cargar un barco era un desastre: barriles de vino que rodaban, sacos de harina que se mojaban y cajas de madera que no encajaban.

**Docker inventó el contenedor estándar para el software:**
- Empaca tu código junto con la versión exacta de Node.js, Python o Linux que necesita.
- No importa en qué computadora se ejecute (la tuya, la de tu amigo o un servidor en Alemania): **el contenedor siempre corre exactamente igual**.

---

## 💔 La Tragedia de Docker Desktop en Computadoras con 8GB de RAM

Si descargas **Docker Desktop** en Windows o Mac:
1. Docker Desktop levanta una máquina virtual Linux completa oculta en segundo plano (WSL2 o Hyper-V).
2. De tus 8GB de RAM, la máquina virtual se reserva automáticamente entre **2.5GB y 4GB**.
3. Te quedan solo 4GB libres para Windows, el navegador y tu editor de código.
4. **Consecuencia:** La computadora se congela, el cursor tiembla y compilar un archivo tarda una eternidad.

---

## 💡 Las 2 Soluciones Pragmáticas de Trinchera

### Opción A: Desarrollo Nativo en Local (Recomendado para PCs modestas)
No uses Docker en tu computadora diaria:
- Instala Node.js o Python directamente en tu sistema operativo.
- Ejecuta `npm run dev` o `python main.py`. Consume apenas **80MB de RAM**.
- Tu computadora vuela y desarrollas con total fluidez.

### Opción B: Docker con Límites Estrictos de Memoria (`.wslconfig`)
Si estás en Windows y es estrictamente obligatorio usar Docker, limita por ley cuánta memoria puede consumir la máquina virtual:
1. Crea un archivo de texto en `C:\Users\TuUsuario\.wslconfig`.
2. Escribe estas líneas:
   ```ini
   [wsl2]
   memory=2GB   # Limita a un máximo de 2GB para no ahogar tu PC
   processors=2 # Limita a 2 núcleos de procesador
   ```
3. Docker respetará ese techo y tu computadora nunca más volverá a colapsar.

*(Encuentra nuestra plantilla lista en [`templates-plug-and-play/docker-compose-low-ram.yml`](../../templates-plug-and-play/docker-compose-low-ram.yml)).*
