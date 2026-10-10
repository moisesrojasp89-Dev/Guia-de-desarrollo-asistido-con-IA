# 📟 Agentes de Terminal: Claude Code y Hermes

> *"Cuando la IA aprende a usar la terminal, deja de ser un asistente de chat para convertirse en un ingeniero junior sentado a tu lado con acceso al teclado."*

---

## ⚡ El Salto a la Terminal (CLI)

Durante mucho tiempo estuvimos acostumbrados a copiar código de una página web o ventana de chat y pegarlo manualmente en nuestro editor.  
Los **Agentes de Terminal** eliminan esa fricción por completo: se ejecutan como un comando dentro de tu consola (Bash, Zsh o PowerShell) y tienen acceso directo a las herramientas del sistema operativo.

---

## 🎩 1. Claude Code (Anthropic CLI)

**Claude Code** es una herramienta oficial de línea de comandos desarrollada por Anthropic que convierte a Claude en un agente terminal interactivo:

```bash
# Ejemplo de uso en terminal:
claude "Agrega validación de correo con Zod en src/auth.ts y corre los tests"
```

### ¿Cómo opera Claude Code por dentro? (El Bucle ReAct)
1. **Inspección:** Usa comandos como `grep`, `find` o `ls` para localizar el archivo sin que tú tengas que indicarle la ruta exacta.
2. **Edición:** Lee el contenido, realiza la modificación atómica y guarda el archivo en disco.
3. **Validación:** Corre automáticamente `npm test` o tu linter para verificar si el cambio rompió algo.
4. **Git Autónomo:** Si todo pasa en verde, puede crear una rama y armar un commit con un mensaje descriptivo listo para revisión.
5. **Permisos y Seguridad:** Antes de ejecutar comandos destructivos (como borrar archivos o instalar paquetes desconocidos), **el agente se detiene y pide tu confirmación explícita** con `[Y/n]`.

---

## 🪽 2. Hermes y Arneses Abiertos (Hermes-Agent)

Mientras que herramientas como Claude Code dependen de modelos propietarios de Anthropic, proyectos como **Hermes** (y arneses de la comunidad de código abierto):

* **Filosofía Abierta:** Permiten conectar modelos con pesos abiertos (como DeepSeek, Llama o Qwen) mediante servidores locales (vLLM, Ollama) o APIs unificadas.
* **Llamada de Funciones Nativa (*Function Calling*):** Permite que cualquier modelo compatible ejecute scripts de Python, lea bases de datos locales o controle navegadores web de forma autónoma y sin costo recurrente de licencias.
* **Ligereza Extrema:** Al no requerir interfaces gráficas pesadas con Electron, consumen menos de 50MB de RAM en tu máquina, respetando computadoras de recursos modestos.

---

## 🛡️ Reglas de Supervivencia con Agentes de Terminal

1. **Nunca los dejes en modo 'Auto-Aprobar Todo' (`--dangerously-skip-permissions`):**  
   Mantén siempre la supervisión humana activa. Un comando `rm -rf` o un script mal diseñado podría borrar archivos locales de tu disco en un parpadeo.
2. **Revisa siempre `git diff` antes de commitear:**  
   Antes de aceptar los cambios de un agente terminal, abre otra pestaña de consola y corre:
   ```bash
   git diff
   ```
   Comprueba con tus propios ojos que cada línea añadida o borrada sea legítima.
