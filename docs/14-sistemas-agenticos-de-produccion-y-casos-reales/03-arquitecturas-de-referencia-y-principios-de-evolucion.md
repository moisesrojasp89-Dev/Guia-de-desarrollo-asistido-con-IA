# 📐 Arquitecturas de Referencia y Principios de Evolución del Harness

> *"El arnés codifica supuestos sobre lo que el modelo NO puede hacer. A medida que los modelos avanzan, esos supuestos caducan y el arnés debe simplificarse. Diseñar un arnés de alto nivel consiste tanto en saber qué controles construir hoy, como en saber qué burocracia podar mañana."*

---

## 🏛️ Tres Patrones Arquitectónicos Comprobados

No existe una única arquitectura válida para todos los casos de uso. Dependiendo de si estás programando en tu máquina local, automatizando un pipeline de CI/CD o construyendo un servicio agéntico en la nube, la industria ha consolidado **tres arquitecturas de referencia**:

---

### Arquitectura 1: Initializer + Coding Agent (Progreso Incremental)

Diseñada para desarrollo iterativo y sesiones prolongadas de programación asistida en terminal o IDE (el modelo adoptado por herramientas como Claude Code o Antigravity).

```mermaid
sequenceDiagram
    autonumber
    actor Dev as Desarrollador
    participant Init as Agente Inicializador
    participant Disco as Estado en Disco (Git / JSON)
    participant Coder as Agente de Código

    Dev->>Init: "Implementa el módulo de autenticación según SPEC.md"
    Init->>Disco: Crea feature_list.json (todas en false)
    Init->>Disco: Crea init.sh y progress.txt
    Note over Init,Disco: Entorno configurado y listo
    
    loop Para cada feature pendiente
        Dev->>Coder: "Siguiente feature"
        Coder->>Disco: Lee feature_list.json y toma la primera pendiente
        Coder->>Coder: Modifica archivos de código
        Coder->>Coder: Ejecuta sensores (tests / linter)
        Coder->>Disco: Actualiza feature a true + Git commit
        Coder->>Disco: Registra bitácora en progress.txt
    end
```

- **Sesión de Inicialización:** Un agente rápido analiza la especificación y crea los artefactos estructurados base:
  - `init.sh` (script de arranque determinista).
  - `feature_list.json` (desglose de requerimientos en estado inicial de fallo).
  - `progress.txt` (bitácora de decisiones).
- **Sesiones de Ejecución:** El agente de código toma **una sola característica a la vez**, ejecuta el cambio, corre los tests, actualiza el estado en disco, crea un commit limpio en Git y finaliza su turno dejando el entorno en perfecto orden.

---

### Arquitectura 2: Triángulo Planner + Generator + Evaluator (Patrón Antagónico)

Inspirada en el balance entre generador y discriminador de las redes GANs, esta arquitectura es la más sólida para tareas autónomas complejas donde la calidad y la seguridad no pueden negociarse.

```mermaid
flowchart TD
    SPEC["📄 ESPECIFICACIÓN / INTENCIÓN HUMANA"] --> PLANNER["🧠 PLANIFICADOR (Planner)\nGenera lista formal de casos de prueba,\nesquemas y criterios de aceptación"]
    
    PLANNER --> GENERATOR["🦾 GENERADOR (Generator)\nImplementa el código y la arquitectura"]
    
    GENERATOR --> EVALUATOR["⚖️ EVALUADOR INDEPENDIENTE (Evaluator)\nEjecuta pruebas en entorno real,\ninspección Playwright y análisis de red"]
    
    EVALUATOR -->|"❌ Rechazado: Evidencia de fallo\n(Screenshots / Stderr / Logs)"| GENERATOR
    EVALUATOR -->|"✅ Aprobado: 100% Sensores en verde"| MERGE["🚀 PR APROBADO / MERGE SEGURO"]
```

| Rol | Responsabilidad Principal | Herramientas Típicas |
|---|---|---|
| **Planificador (*Planner*)** | Descomponer la intención en requerimientos técnicos atómicos y definir el contrato de éxito. | Lectura de documentación, analizador de esquemas. |
| **Generador (*Generator*)** | Escribir código limpio, modular y apegado a los contratos. | Escritura y edición de archivos, creación de componentes. |
| **Evaluador (*Evaluator*)** | Juzgar el trabajo con escepticismo radical; jamás confiar en palabras. | Navegador headless (Playwright), linters, suites de tests, llamadas cURL. |

---

### Arquitectura 3: Session / Harness / Sandbox (Managed Agents en la Nube)

La arquitectura estándar para desplegar flujos agénticos en servidores, entornos multi-inquilino (*multi-tenant*) y plataformas de infraestructura en la nube:

```mermaid
flowchart LR
    subgraph CAPA_DATOS ["Fuente de Verdad Persistente"]
        SESSION["📜 SESSION\nLog inmutable append-only\nAlmacena eventos, pensamientos y trazas\nSobrevive a caídas de servidor"]
    end

    subgraph CAPA_LOGICA ["Bucle de Control Agéntico"]
        HARNESS["⚙️ HARNESS STATELESS\nOrquestador sin memoria interna\nConsume eventos de la sesión\nPuede reiniciarse o migrar de nodo"]
    end

    subgraph CAPA_EJECUCION ["Entorno de Aislamiento Físico"]
        SANDBOX["📦 SANDBOX / MICRO-VM\nContenedor efímero con red controlada\nEjecuta bash, compiladores y tests\nCERO acceso a credenciales maestras"]
    end

    SESSION <-->|Lectura de estado / Escritura de trazas| HARNESS
    HARNESS <-->|Despacho de comandos seguros / Retorno de stdout| SANDBOX
```

- **Session (Persistencia Inmutable):** Es un registro append-only de cada paso ejecutado. Si una máquina falla, cualquier otro worker puede leer el log y reanudar la tarea en el milisegundo exacto donde se detuvo.
- **Harness (Lógica Desacoplada):** No guarda variables en memoria volátil; es completamente reemplazable y escalable horizontalmente.
- **Sandbox (Seguridad Estricta):** El código generado por la IA corre en un entorno estanco. Las credenciales de nube jamás ingresan al contenedor; el sandbox solo puede interactuar con el mundo mediante las APIs intermediadas por el harness.

---

## ✂️ Principios de Evolución del Harness (La Regla de la Poda)

El mayor peligro al construir sistemas con IA no es quedarse corto de herramientas, sino **acumular burocracia técnica innecesaria**.

> [!IMPORTANT]
> **La Ley de Obsolescencia de Supuestos:**  
> Todo arnés codifica supuestos sobre lo que el modelo de lenguaje **no es capaz de hacer**.  
> Conforme los modelos de frontera evolucionan y adquieren mayores ventanas de contexto y mejor razonamiento causal, **muchos de esos supuestos caducan**. Si no podas tu arnés, terminarás asfixiando al modelo con restricciones obsoletas.

### Ejemplos Reales de Poda en la Industria:
1. **Eliminación de Context Resets Forzados:** Antes se reseteaba la memoria cada 5 mensajes por miedo a la degradación de atención; con modelos modernos con atención de millones de tokens y baja pérdida intermedia, este reseteo artificial se eliminó.
2. **Eliminación de Micro-Sprints Burocráticos:** Forzar a un modelo avanzado a pedir permiso humano para cada creación de archivo individual ralentiza el flujo sin aportar seguridad real si ya cuentas con un linter y Git diff.
3. **Poda de Prompts Redundantes:** Quitar recordatorios como *"recuerda importar React from 'react'"* cuando el modelo ya lo hace de forma nativa por entrenamiento.

---

## 🎯 La Regla de Oro para el Constructor

```mermaid
flowchart LR
    M1["1. Arnés Mínimo Viable\n(Observar → Verificar → Recuperar)"] --> M2["2. Aparece un fallo repetido en producción"]
    M2 --> M3["3. Añadir sensor o restricción mecánica específica"]
    M3 --> M4["4. Nuevo modelo más capaz lanzado"]
    M4 --> M5["5. Auditar y PODAR controles que ya no aporten valor"]
    M5 --> M1
```

1. **Arranca con el arnés mínimo que cierre el ciclo:** Un linter, un comando de test y un script de rollback.
2. **Añade complejidad solo cuando una clase de error real lo exija.**
3. **Poda sin piedad:** Cada línea en tu arnés consume tokens y atención. Mantén tu arnés tan afilado y liviano como sea posible.
