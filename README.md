# 🧭 Guía Práctica y Abierta de Vibe Coding & Harness Engineering
### De la Idea a Producción con Inteligencia Artificial

[![Licencia MIT](https://img.shields.io/badge/Código-MIT-blue.svg)](LICENSE)
[![Documentación CC BY-SA](https://img.shields.io/badge/Docs-CC%20BY--SA%204.0-orange.svg)](LICENSE)
[![Nivel: Abierto para Todos](https://img.shields.io/badge/Nivel-Principiante%20a%20Senior-success.svg)](#-para-quién-es-este-repositorio)
[![Pragmatismo Real](https://img.shields.io/badge/Filosofía-Pragmatismo%20Real-purple.svg)](#-1-la-filosofía-de-la-trinchera)

> **Mandamiento #1 del Constructor:**  
> *"Antes de tirar la primera línea de código, diseña en una servilleta: documentación clara, diagramas de flujo y arquitectura básica. Si tú no tienes claro el mapa, la IA inventará un laberinto."*

---

## 🌟 ¿De qué se trata este repositorio?

Este no es un curso teórico ni un manual académico inflado con términos de moda. **Es una guía de trinchera**, nacida de meses de trabajo real construyendo sistemas funcionales (desde pasarelas de cobro y paneles de datos hasta servicios de mensajería transaccional y plataformas web) mano a mano con modelos de Inteligencia Artificial como Claude, GPT, Gemini, Cursor y Antigravity.

Aquí aprenderás a dar el salto fundamental: **dejar de ser un usuario que copia y pega código a ciegas para convertirte en un director de orquesta (Harness Engineer)** que sabe qué pedir, cómo proteger su sistema, cómo validar cada paso y cómo construir software profesional, sin importar si vienes de la informática tradicional o si estás programando por primera vez.

---

## 👋 ¿Para quién es este repositorio?

Este proyecto fue diseñado con **neutralidad absoluta de casos de uso**. Sirve exactamente igual para crear una tienda de comercio electrónico, un sistema de reservas para un consultorio, un bot automatizado, un panel de control empresarial o un SaaS:

* 🟢 **Para Creadores, Emprendedores y Vibe Coders sin trasfondo técnico:**  
  Aprenderás a pensar antes de programar, a dialogar con los modelos con analogías cotidianas y a estructurar tus ideas para que la IA no arruine tu proyecto al tercer día.
* 🟡 **Para Personas con Presupuesto o Hardware Limitado (Poca RAM):**  
  Desmentimos el mito de que necesitas computadoras costosas de 32GB de RAM o servidores caros. Te enseñamos a desarrollar ligero en local y a delegar el trabajo pesado a herramientas gratuitas en la nube.
* 🔵 **Para Desarrolladores Tradicionales y Líderes Técnicos:**  
  Descubrirás cómo aplicar ingeniería de arneses (*Harness Engineering*), compuertas de calidad automáticas (*Quality Gates*), máquinas de estado finito y catálogos de auto-aprendizaje continuo (5-Whys) para evitar que los asistentes agénticos degraden tu base de código.

---

## 🗺️ Mapa de Ruta Completo del Repositorio

El contenido está dividido en **13 módulos progresivos**, acompañados de plantillas listas para copiar y pegar y hojas de trucos rápidos.

```mermaid
flowchart TD
    M0["0. Filosofía & Recursos Humildes\n(Vencer la falta de RAM)"] --> M1["1. El Paso Cero: Arquitectura en Servilleta\n(Flujo, Datos y SPEC.md)"]
    M1 --> M2["2. Orquestación de Modelos\n(Modelos Rápidos vs Frontera)"]
    M2 --> M3["3. Fundamentos Web Cotidianos\n(El Restaurante Digital: HTML/CSS/JS)"]
    M3 --> M4["4. Triángulo de Seguridad Defensiva\n(Prueba F12, HMAC y RLS)"]
    M4 --> M5["5. Infraestructura con Manzanas\n(Hosting vs VPS vs Tunnels)"]
    M5 --> M6["6. Resiliencia de Datos\n(Webhooks, Idempotencia, ACID)"]
    M6 --> M7["7. UI/UX Esencial\n(Los 4 Estados Sagrados & Móvil)"]
    M7 --> M8["8. Gobernanza Agéntica (AGENTS.md)\n(Matriz Anti-Atajos)"]
    M8 --> M9["9. Harness Engineering\n(Modelo + Arnés & Guardrails)"]
    M9 --> M10["10. Arquitectura Limpia\n(Anti-Monolito de 3,000 líneas)"]
    M10 --> M11["11. Auto-Aprendizaje & Calidad\n(5-Whys y Quality Gates)"]
    M11 --> M12["12. El Ecosistema de Herramientas\n(Cursor, Antigravity, OpenRouter, APIs)"]
    M12 --> PROD["🚀 PUESTA EN PRODUCCIÓN CONFIABLE"]
```

---

### 📚 Índice Detallado de Módulos

| Módulo | Enfoque Central | Documentos Clave |
|---|---|---|
| **[00. Filosofía y Primeros Pasos](docs/00-filosofia-y-primeros-pasos/)** | Mentalidad pragmática, domar la complacencia del modelo y vencer limitaciones de RAM. | • [01. ¿Qué es Vibe Coding con criterio?](docs/00-filosofia-y-primeros-pasos/01-que-es-vibe-coding-con-criterio.md)<br>• [02. La complacencia de los modelos](docs/00-filosofia-y-primeros-pasos/02-la-complacencia-de-los-modelos-y-como-domarla.md)<br>• [03. De copia-pegador a director de orquesta](docs/00-filosofia-y-primeros-pasos/03-de-copia-pegador-a-director-de-orquesta.md)<br>• [04. Construye con lo que tienes (RAM humilde)](docs/00-filosofia-y-primeros-pasos/04-construye-con-lo-que-tienes-vencer-la-falta-de-ram.md) |
| **[01. Antes del Código: Diseño y Arquitectura](docs/01-antes-del-codigo-diseno-y-arquitectura/)** | 🌟 **EL PASO CERO OBLIGATORIO:** No abras el chat a ciegas. Diagramas simples, datos y SPEC.md. | • [01. La regla de oro: No abras el chat a ciegas](docs/01-antes-del-codigo-diseno-y-arquitectura/01-la-regla-de-oro-no-abras-el-chat-a-ciegas.md)<br>• [02. Diagramas de flujo simples (El viaje)](docs/01-antes-del-codigo-diseno-y-arquitectura/02-diagramas-de-flujo-simples-el-viaje-del-usuario.md)<br>• [03. Arquitectura en servilleta](docs/01-antes-del-codigo-diseno-y-arquitectura/03-arquitectura-en-servilleta-quien-habla-con-quien.md)<br>• [04. El mapa de datos esencial](docs/01-antes-del-codigo-diseno-y-arquitectura/04-el-mapa-de-datos-las-tablas-esenciales.md)<br>• [05. Cómo redactar tu primer SPEC.md](docs/01-antes-del-codigo-diseno-y-arquitectura/05-como-redactar-tu-primer-spec-md.md) |
| **[02. Orquestación y Modelos](docs/02-orquestacion-y-seleccion-de-modelos/)** | Cómo hablarle al modelo, abstracción y combinación híbrida para ahorrar hasta un 90% en costos. | • [01. Cómo hablarle a un modelo](docs/02-orquestacion-y-seleccion-de-modelos/01-como-hablarle-a-un-modelo-lenguaje-y-abstraccion.md)<br>• [02. Modelos modestos vs de frontera](docs/02-orquestacion-y-seleccion-de-modelos/02-modelos-modestos-vs-modelos-de-frontera.md)<br>• [03. El flujo híbrido de eficiencia](docs/02-orquestacion-y-seleccion-de-modelos/03-el-flujo-hibrido-ahorro-y-eficiencia.md) |
| **[03. Fundamentos Web sin Tecnicismos](docs/03-fundamentos-web-sin-tecnicismos/)** | La analogía del restaurante digital, cómo viajan los datos por internet y qué ve el navegador. | • [01. La analogía del restaurante (HTML/CSS/JS)](docs/03-fundamentos-web-sin-tecnicismos/01-la-analogia-del-restaurante-html-css-js.md)<br>• [02. Cómo viajan los datos (HTTP y WebSockets)](docs/03-fundamentos-web-sin-tecnicismos/02-como-viajan-los-datos-por-internet-http-y-ws.md)<br>• [03. El renderizado y el DOM](docs/03-fundamentos-web-sin-tecnicismos/03-el-renderizado-que-ve-el-usuario.md) |
| **[04. El Triángulo de Seguridad Defensiva](docs/04-el-triangulo-de-seguridad-defensiva/)** | Prueba F12, firmas criptográficas HMAC, Row Level Security (RLS) y la trampa del `display: none`. | • [01. Seguridad Web: F12 y cero fugas](docs/04-el-triangulo-de-seguridad-defensiva/01-seguridad-en-la-web-f12-xss-y-cero-fugas.md)<br>• [02. Seguridad Backend: HMAC y Rate Limiting](docs/04-el-triangulo-de-seguridad-defensiva/02-seguridad-en-el-backend-firmas-hmac-y-rate-limiting.md)<br>• [03. Seguridad en BD: RLS y Mínimo Privilegio](docs/04-el-triangulo-de-seguridad-defensiva/03-seguridad-en-la-bd-row-level-security-rls-y-minimo-privilegio.md)<br>• [04. La trampa mortal del display: none](docs/04-el-triangulo-de-seguridad-defensiva/04-la-trampa-mortal-del-display-none.md) |
| **[05. Infraestructura Explicada con Manzanas](docs/05-infraestructura-explicada-con-manzanas/)** | Hosting estático vs VPS vs Serverless, Docker liviano, GitHub Actions gratuitos y Cloudflare Tunnels. | • [01. Hosting vs VPS vs Serverless](docs/05-infraestructura-explicada-con-manzanas/01-que-es-un-hosting-vs-vps-vs-serverless.md)<br>• [02. Dimensionamiento de Hardware (RAM/CPU)](docs/05-infraestructura-explicada-con-manzanas/02-dimensionamiento-de-hardware-cuanta-ram-y-cpu-necesitas.md)<br>• [03. Docker y cómo convivir con tu RAM](docs/05-infraestructura-explicada-con-manzanas/03-que-es-docker-y-por-que-lo-amas-u-odias-segun-tu-ram.md)<br>• [04. GitHub Actions: Tu inspector gratuito](docs/05-infraestructura-explicada-con-manzanas/04-github-actions-tu-robot-gratuito-de-inspeccion.md)<br>• [05. Tunnels: Probar webhooks en casa](docs/05-infraestructura-explicada-con-manzanas/05-tunnels-cloudflare-y-ngrok-probar-webhooks-en-casa.md) |
| **[06. Resiliencia de Datos en el Mundo Real](docs/06-resiliencia-de-datos-en-el-mundo-real/)** | Webhooks como timbres de casa, Idempotencia anti-duplicados, Transacciones ACID y Circuit Breakers. | • [01. Webhooks: El timbre de tu casa](docs/06-resiliencia-de-datos-en-el-mundo-real/01-que-es-un-webhook-el-timbre-de-tu-casa.md)<br>• [02. Idempotencia: Cero cobros duplicados](docs/06-resiliencia-de-datos-en-el-mundo-real/02-idempotencia-como-evitar-cobros-y-mensajes-duplicados.md)<br>• [03. Atomicidad ACID: Todo o nada](docs/06-resiliencia-de-datos-en-el-mundo-real/03-atomicidad-acid-la-regla-de-oro-del-todo-o-nada.md)<br>• [04. Circuit Breakers y Outbox pattern](docs/06-resiliencia-de-datos-en-el-mundo-real/04-circuit-breaker-y-outbox-cuando-las-apis-se-caen.md) |
| **[07. Diseño UI/UX para Vibe Coders](docs/07-diseno-ui-ux-para-vibe-coders/)** | Los 4 estados sagrados de interfaz, tokens visuales, ergonomía táctil móvil y microinteracciones. | • [01. Los 4 estados: Loading, Empty, Error, Success](docs/07-diseno-ui-ux-para-vibe-coders/01-los-cuatro-estados-sagrados-loading-empty-error-success.md)<br>• [02. Tokens CSS y paletas coherentes](docs/07-diseno-ui-ux-para-vibe-coders/02-tokens-css-y-paletas-coherentes.md)<br>• [03. Mobile First y ergonomía táctil](docs/07-diseno-ui-ux-para-vibe-coders/03-mobile-first-y-ergonomia-tactil.md)<br>• [04. Microinteracciones y feedback inmediato](docs/07-diseno-ui-ux-para-vibe-coders/04-microinteracciones-y-feedback-inmediato.md) |
| **[08. Gobernanza del Asistente (AGENTS.md)](docs/08-gobernanza-del-asistente-agents-md/)** | Instrucciones inquebrantables, matriz anti-atajos y ciclo SDLC agéntico en 6 pasos. | • [01. ¿Qué es un arnés de instrucciones?](docs/08-gobernanza-del-asistente-agents-md/01-que-es-un-harness-de-instrucciones.md)<br>• [02. La matriz anti-atajos del modelo](docs/08-gobernanza-del-asistente-agents-md/02-la-matriz-anti-atajos-del-modelo.md)<br>• [03. El ciclo SDLC agéntico en 6 pasos](docs/08-gobernanza-del-asistente-agents-md/03-el-ciclo-sdlc-agentico-en-6-pasos.md) |
| **[09. Harness Engineering y Lógica Robusta](docs/09-harness-engineering-y-logica-robusta/)** | La fórmula Modelo + Harness, Máquinas de Estado Finito, Guardrails por código y Progressive Disclosure. | • [01. La fórmula Modelo + Harness](docs/09-harness-engineering-y-logica-robusta/01-la-formula-modelo-mas-harness.md)<br>• [02. Máquinas de estado en flujos de negocio](docs/09-harness-engineering-y-logica-robusta/02-maquinas-de-estado-en-flujos-de-negocio.md)<br>• [03. Guardrails por código vs texto](docs/09-harness-engineering-y-logica-robusta/03-guardrails-por-codigo-vs-guardrails-por-texto.md)<br>• [04. Gestión de contexto progresivo](docs/09-harness-engineering-y-logica-robusta/04-gestion-de-contexto-y-progressive-disclosure.md) |
| **[10. Arquitectura Limpia y Modularidad](docs/10-arquitectura-limpia-y-modularidad/)** | Cómo evitar el archivo monstruo de 3,000 líneas, pureza de imports sin efectos secundarios y separación. | • [01. El archivo monstruo y cómo evitarlo](docs/10-arquitectura-limpia-y-modularidad/01-como-evitar-el-archivo-monstruo-de-3000-lineas.md)<br>• [02. Pureza de importación (Zero Side-Effects)](docs/10-arquitectura-limpia-y-modularidad/02-pureza-de-importacion-cero-efectos-colaterales.md)<br>• [03. Separación de responsabilidades](docs/10-arquitectura-limpia-y-modularidad/03-separacion-de-responsabilidades.md) |
| **[11. Auto-Aprendizaje y Calidad](docs/11-auto-aprendizaje-y-calidad/)** | La técnica de los 5-Whys para bugs, catálogo persistente de errores, pruebas <5s con mocks y Quality Gates. | • [01. Técnica de los 5-Porqués](docs/11-auto-aprendizaje-y-calidad/01-la-tecnica-de-los-5-porques-para-bugs.md)<br>• [02. Catálogo de errores persistente](docs/11-auto-aprendizaje-y-calidad/02-catalogo-de-errores-persistente.md)<br>• [03. Pruebas sub-5 segundos con mocks](docs/11-auto-aprendizaje-y-calidad/03-pruebas-rapidas-sub-5-segundos-con-mocks.md)<br>• [04. Quality Gates en 1 solo comando](docs/11-auto-aprendizaje-y-calidad/04-quality-gates-en-un-solo-comando.md) |
| **[12. El Ecosistema de Herramientas y Harnesses](docs/12-el-ecosistema-de-herramientas-y-harnesses/)** | 🛠️ APIs vs Suscripciones, OpenRouter, DeepSeek vs Claude vs Gemini, Cursor, Antigravity, Claude Code y Multiagentes (Orca). | • [01. ¿Qué es una API y cómo se paga?](docs/12-el-ecosistema-de-herramientas-y-harnesses/01-que-es-una-api-y-como-se-paga-tokens-vs-suscripcion.md)<br>• [02. ¿Qué es OpenRouter? El mercado central](docs/12-el-ecosistema-de-herramientas-y-harnesses/02-que-es-openrouter-el-mercado-central-de-modelos.md)<br>• [03. Los modelos de referencia (DeepSeek, Claude, Gemini, GPT)](docs/12-el-ecosistema-de-herramientas-y-harnesses/03-los-modelos-de-referencia-deepseek-claude-gemini-gpt.md)<br>• [04. Editores: Cursor vs Antigravity vs Copilot](docs/12-el-ecosistema-de-herramientas-y-harnesses/04-editores-y-entornos-cursor-vs-antigravity-vs-copilot.md)<br>• [05. Agentes de Terminal: Claude Code y Hermes](docs/12-el-ecosistema-de-herramientas-y-harnesses/05-agentes-de-terminal-claude-code-y-hermes.md)<br>• [06. Orquestación Multiagente y la Nube (Orca)](docs/12-el-ecosistema-de-herramientas-y-harnesses/06-orquestacion-multiagente-y-plataformas-en-la-nube-orca.md) |

---

## 🧰 Plantillas Listas para Copiar y Pegar (`templates-plug-and-play/`)

No te dejamos solo con la teoría. Hemos incluido archivos listos para usar en tus propios repositorios:

* 📄 **[`spec-de-proyecto-starter.md`](templates-plug-and-play/spec-de-proyecto-starter.md)**: Plantilla interactiva para diseñar tu aplicación y definir tus límites antes de abrir el chat de IA.
* 🤖 **[`AGENTS-universal.md`](templates-plug-and-play/AGENTS-universal.md)**: Arnés universal de instrucciones para configurar Cursor, Claude, Windsurf, Copilot o Antigravity.
* 📓 **[`self_learning_error_catalog.md`](templates-plug-and-play/self_learning_error_catalog.md)**: Formato estructurado 5-Whys para registrar fallas y evitar que la IA repita errores pasados.
* 🐍 **[`quality_gate_python.py`](templates-plug-and-play/quality_gate_python.py)**: Script en Python para auditar tipos, sintaxis, secretos expuestos y tests en menos de 3 segundos.
* ⚡ **[`quality_gate_node.ts`](templates-plug-and-play/quality_gate_node.ts)**: Script equivalente para TypeScript/Node.js con análisis estático y escaneo de credenciales.
* 🔐 **[`supabase-rls-starter.sql`](templates-plug-and-play/supabase-rls-starter.sql)**: Plantilla SQL para activar Row Level Security (RLS) en PostgreSQL/Supabase con aislamiento multi-usuario.
* 🛡️ **[`webhook-verifier-node.ts`](templates-plug-and-play/webhook-verifier-node.ts)**: Validador criptográfico HMAC para asegurar webhooks de Stripe, WhatsApp/Meta, Shopify, etc.
* 🐳 **[`docker-compose-low-ram.yml`](templates-plug-and-play/docker-compose-low-ram.yml)**: Configuración ultra-optimizada con límites estrictos de memoria para no ahogar tu computadora.
* 🤖 **[`github-actions-ci.yml`](templates-plug-and-play/github-actions-ci.yml)**: Flujo de integración continua listo para correr tus Quality Gates automáticamente en cada push.
* 🎨 **[`ui-feedback-states.css`](templates-plug-and-play/ui-feedback-states.css)**: Clases CSS listas para manejar estados de carga, listas vacías, alertas de error y mensajes de éxito.
* 🛫 **[`checklist_preflight.md`](templates-plug-and-play/checklist_preflight.md)**: Lista de verificación rigurosa de 10 puntos antes de abrir las puertas a usuarios reales.

---

## 📌 Hojas de Consulta Rápida (`cheat-sheets/`)

* 🗺️ **[`mapa-del-ecosistema-ia.md`](cheat-sheets/mapa-del-ecosistema-ia.md)**: Cuadro de mando comparativo de IDEs (Cursor, Antigravity), modelos (DeepSeek, Claude, Gemini) y plataformas (OpenRouter).
* 📖 **[`diccionario-dev-para-todos.md`](cheat-sheets/diccionario-dev-para-todos.md)**: Glosario sin enredos de términos técnicos comunes (API, JWT, Webhook, Mock, Transacción, DNS, etc.).
* 📊 **[`plantillas-diagramas-mermaid.md`](cheat-sheets/plantillas-diagramas-mermaid.md)**: Diagramas visuales en texto listos para pegar en tu documentación.
* 💬 **[`prompts-de-control-arquitectonico.md`](cheat-sheets/prompts-de-control-arquitectonico.md)**: Fórmulas exactas para dar instrucciones firmes a la IA y evitar que tome atajos mediocres.
* 🚦 **[`semaforo-de-riesgo-de-codigo.md`](cheat-sheets/semaforo-de-riesgo-de-codigo.md)**: Guía rápida para saber qué partes del código generado por IA debes revisar con lupa.
* 💰 **[`guia-hardware-y-costos.md`](cheat-sheets/guia-hardware-y-costos.md)**: Recomendaciones realistas de RAM, CPU y servicios gratuitos para arrancar con $0 USD.

---

## 🚀 Cómo Empezar a Usar Esta Guía Hoy Mismo

1. **Si vas a iniciar una idea desde cero:**  
   Ve directamente al **[Módulo 01: Antes del Código](docs/01-antes-del-codigo-diseno-y-arquitectura/01-la-regla-de-oro-no-abras-el-chat-a-ciegas.md)** y copia la plantilla [`spec-de-proyecto-starter.md`](templates-plug-and-play/spec-de-proyecto-starter.md). Llena los 4 pasos y preséntaselos a tu IA.
2. **Si ya tienes un proyecto en marcha que se siente frágil o desordenado:**  
   Lee el **[Módulo 08: Gobernanza del Asistente](docs/08-gobernanza-del-asistente-agents-md/01-que-es-un-harness-de-instrucciones.md)** y coloca [`AGENTS-universal.md`](templates-plug-and-play/AGENTS-universal.md) en la raíz de tu proyecto para educar a tu asistente.
3. **Si te preocupa la seguridad o vas a conectar pagos o webhooks:**  
   Revisa el **[Módulo 04: Triángulo de Seguridad](docs/04-el-triangulo-de-seguridad-defensiva/01-seguridad-en-la-web-f12-xss-y-cero-fugas.md)** y el **[Módulo 06: Resiliencia de Datos](docs/06-resiliencia-de-datos-en-el-mundo-real/01-que-es-un-webhook-el-timbre-de-tu-casa.md)**.

---

## 🤝 Cómo Contribuir

Este repositorio es una bitácora abierta y en evolución. Si aprendiste una lección dura en la trinchera, descubriste un nuevo atajo dañino que los modelos suelen tomar, o tienes una analogía más clara para explicar un concepto difícil:

1. Lee nuestras pautas en [`CONTRIBUTING.md`](CONTRIBUTING.md).
2. Abre un Issue o un Pull Request.
3. Ayúdanos a mantener este recurso pragmático, accesible y con rigor técnico.

---

## ⚖️ Licencias

* **Código de plantillas y scripts:** [Licencia MIT](LICENSE) (úsalos, cópialos y adáptalos libremente en tus proyectos personales o comerciales).
* **Guías escritas y documentación:** [Creative Commons Atribución-CompartirIgual 4.0 Internacional (CC BY-SA 4.0)](LICENSE).
