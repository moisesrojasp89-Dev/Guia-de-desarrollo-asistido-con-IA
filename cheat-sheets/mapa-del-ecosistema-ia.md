# 🗺️ Mapa Rápido del Ecosistema de Herramientas de IA

> *"Una tabla de referencia rápida para no perderte entre nombres comerciales, siglas y plataformas."*

---

## 🗂️ 1. Editores, IDEs y Arneses Agénticos

| Herramienta | Tipo | ¿Dónde corre? | Fortaleza Principal | Costo Típico |
|---|---|---|---|---|
| **Cursor** | IDE (Fork de VS Code) | Tu computadora | Autocompletado multi-archivo con Composer y menciones `@codebase`. | Plan gratuito o $20 USD / mes. |
| **Google Antigravity** | Entorno Agéntico Completo | Entorno de desarrollo | Subagentes especializados, ejecución nativa de herramientas, artefactos y desvelo reactivo. | Integrado en ecosistema Google. |
| **GitHub Copilot** | Extensión de Editor | VS Code / JetBrains | Autocompletado en línea mientras escribes sin cambiar tu flujo. | $10 USD / mes (o gratis para estudiantes/open source). |
| **Claude Code** | Agente de Terminal (CLI) | Tu consola (Bash/Zsh) | Edita archivos, corre tests y hace git commits de forma autónoma. | Pago por consumo de API de Anthropic. |
| **Hermes / Hermes-Agent** | Arnés Abierto CLI | Terminal / Local | Ejecuta herramientas con modelos de código abierto sin licencias cerradas. | Gratuito / Código abierto. |
| **Orca / CrewAI** | Orquestador Multiagente | Servidores en la nube | Equipos de agentes que colaboran de fondo mediante disparadores y webhooks. | Pago por tokens o infraestructura cloud. |

---

## 🧠 2. Modelos de Lenguaje Principales

| Modelo | Desarrollador | Tipo | Ideal para: |
|---|---|---|---|
| **Claude 3.7 Sonnet** | Anthropic | Propietario (API) | **El mejor para programar:** máxima precisión, refactorización y respeto a reglas. |
| **DeepSeek-R1** | DeepSeek | Pesos Abiertos / API | **Razonamiento profundo:** pensamiento explícito (`<think>`) a costo ultra-bajo. |
| **DeepSeek-V3** | DeepSeek | Pesos Abiertos / API | **Velocidad y economía:** autocompletado y código estándar por fracciones de centavo. |
| **Gemini 2.5 / 3.0 Flash**| Google | Propietario (API) | **Latencia ultra-baja (<300ms):** chatbots, clasificación y tareas mecánicas masivas. |
| **Gemini Pro (1M - 2M)** | Google | Propietario (API) | **Contexto gigante:** analizar libros enteros, videos o repositorios de 200 archivos. |
| **GPT-4o / Serie 'o'** | OpenAI | Propietario (API) | **Uso general y matemáticas:** algoritmos complejos y visión multimodal. |

---

## 🔌 3. Plataformas y Enrutadores

| Concepto | ¿Qué es? | ¿Por qué te importa? |
|---|---|---|
| **API Key** | Contraseña secreta para que tu código llame a un modelo. | Se paga por token consumido (centavos), NO es la suscripción de $20 de ChatGPT. |
| **OpenRouter** | El mercado central de modelos con una sola API Key. | Permite usar Claude, DeepSeek, GPT y Gemini con una sola tarjeta y un solo saldo prepagado de $5 USD. |
| **Ollama** | Programa para correr modelos en tu propia PC. | Para usar IA 100% gratis y sin internet si tu computadora tiene al menos 16GB de RAM. |
| **vLLM** | Motor de inferencia de alto rendimiento para servidores. | Para servir modelos de código abierto a máxima velocidad en servidores VPS o GPU. |
