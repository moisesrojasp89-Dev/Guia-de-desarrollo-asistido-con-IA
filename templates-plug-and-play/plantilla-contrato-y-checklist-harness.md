# 🪢 Plantilla Universal: Contrato Agéntico, Memoria y Checklist de Harness

> *"El arnés no es una idea abstracta; es un conjunto de archivos tangibles en tu repositorio que acotan la intención del agente, persisten su progreso fuera del chat y auditan su trabajo antes de tocar producción."*

---

## 📦 Contenido de esta Plantilla

Esta plantilla agrupa los cuatro artefactos esenciales del **Harness Engineering** listos para copiar, pegar y adaptar a cualquier proyecto:
1. **Contrato de Tarea Agéntica (`task-contract.json` / Markdown):** Acota la tarea y evita la redefinición silenciosa de objetivos (*Goal Drift*).
2. **Registro de Estado Durable (`feature_list.json` & `agent-progress.txt`):** Persistencia fuera de la ventana de contexto.
3. **Recibo de Cambio por Ejecución (`change-receipt.json`):** Trazabilidad de cómo se produjo el cambio para auditorías.
4. **Checklist de Auditoría de 10 Puntos:** Compuerta final antes de habilitar autonomía en producción.

---

## 1. Contrato de Tarea Agéntica (`task-contract.json`)

Guarda este archivo en `.harness/task-contract.json` o en la raíz de tu proyecto al iniciar una sesión de trabajo de alta complejidad:

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "task_id": "AUTH-042-REFRESH-TOKEN",
  "title": "Implementar rotación segura de Refresh Tokens en Redis",
  "created_at": "2026-11-03T10:00:00Z",
  "author": "arquitecto-humano",
  "scope": {
    "files_allowed_to_modify": [
      "src/auth/token-service.ts",
      "src/auth/token-service.test.ts",
      "src/config/redis.ts"
    ],
    "files_strictly_read_only": [
      "src/database/schema.prisma",
      ".env",
      "package.json"
    ]
  },
  "invariants": [
    "No se permite almacenar tokens en texto plano; deben usar hash SHA-256.",
    "El tiempo de vida (TTL) del refresh token no puede exceder los 7 días.",
    "Bajo ninguna circunstancia se deben exponer secretos o contraseñas en los logs de consola."
  ],
  "tools_authorized": [
    "read_file",
    "edit_file",
    "run_npm_test",
    "run_linter"
  ],
  "definition_of_done": {
    "tests_required": [
      "npm run test:auth"
    ],
    "linter_required": "npm run lint",
    "min_test_coverage_percent": 90,
    "clean_git_diff": true
  },
  "budget_limits": {
    "max_iterations": 4,
    "max_duration_minutes": 15,
    "action_on_budget_exceeded": "freeze_and_alert_human"
  }
}
```

---

## 2. Artefactos de Memoria Durable

### A. Lista de Requerimientos con Default-Fail (`feature_list.json`)
Ubícalo en `.harness/feature_list.json`. Todos los ítems comienzan en `false` y solo pasan a `true` cuando el test correspondiente emite código de salida 0:

```json
[
  {
    "id": "F01",
    "description": "Generar refresh token criptográficamente seguro (UUID v4 + secret HMAC)",
    "status": false,
    "evidence": null
  },
  {
    "id": "F02",
    "description": "Guardar hash en Redis con TTL de 7 días exactos",
    "status": false,
    "evidence": null
  },
  {
    "id": "F03",
    "description": "Invalidar token anterior inmediatamente tras la rotación (anti-replay attack)",
    "status": false,
    "evidence": null
  },
  {
    "id": "F04",
    "description": "Test de integración negativo: rechazar token revocado con HTTP 401",
    "status": false,
    "evidence": null
  }
]
```

### B. Bitácora de Sesión Append-Only (`agent-progress.txt`)
Ubícalo en `.harness/agent-progress.txt`. El agente añade entradas al final de cada iteración, permitiendo que cualquier sesión futura reanude el trabajo sin perder el hilo:

```text
=== SESIÓN DE AGENTE: AUTH-042 ===
[2026-11-03 10:05:12] INICIO: Lectura de SPEC.md y task-contract.json completada.
[2026-11-03 10:08:45] CAMBIO: Implementada función generateRefreshToken() en token-service.ts.
[2026-11-03 10:09:30] SENSOR: npm run test:auth falló con 1 error (F02 Redis TTL no configurado).
[2026-11-03 10:12:10] CORRECCIÓN: Añadido parámetro EX a comando SET en redis.ts.
[2026-11-03 10:13:00] SENSOR: npm run test:auth PASÓ (4/4 tests en verde).
[2026-11-03 10:13:20] ESTADO: Actualizado feature_list.json (F01 a F04 completados).
[2026-11-03 10:14:00] GIT: Commit atómico 4f82a1b generado. Tarea lista para revisión humana.
```

---

## 3. Recibo de Cambio por Ejecución (`change-receipt.json`)

Generado por el arnés al finalizar una tarea. Permite auditorías de seguridad, optimización de costos y comparación objetiva entre modelos:

```json
{
  "task_id": "AUTH-042-REFRESH-TOKEN",
  "agent_model": "claude-3-7-sonnet-20250219",
  "execution_summary": {
    "started_at": "2026-11-03T10:05:00Z",
    "finished_at": "2026-11-03T10:14:00Z",
    "duration_seconds": 540,
    "total_tokens_consumed": 18450,
    "estimated_cost_usd": 0.082,
    "iterations_used": 2,
    "max_iterations_allowed": 4
  },
  "sensor_evidence": {
    "linter_status": "PASSED (exit_code: 0)",
    "tests_run": 4,
    "tests_passed": 4,
    "tests_failed": 0
  },
  "git_metadata": {
    "branch": "feature/auth-refresh-token",
    "commit_hash": "4f82a1b9c3e7d12",
    "files_changed_count": 3,
    "lines_added": 84,
    "lines_removed": 12
  },
  "human_review_required": false
}
```

---

## 4. Checklist Interactivo de Auditoría de Harness (10 Compuertas)

Copia esta tabla en tus notas de Pull Request o en la documentación de tu pipeline:

```markdown
### 🛡️ Auditoría de Harness Previa a Producción

- [ ] **1. Contrato Acotado:** ¿Existe un archivo de requerimientos con inputs, outputs e invariantes innegociables?
- [ ] **2. Mapa de Conocimiento:** ¿El agente tiene un `AGENTS.md` conciso con enlaces bajo demanda (progressive disclosure)?
- [ ] **3. Repositorio como Verdad:** ¿Toda la arquitectura y documentación crítica vive versionada en el repo?
- [ ] **4. Herramientas con Salida y Fallo Explícito:** ¿Las herramientas retornan código de salida, stdout y stderr claros?
- [ ] **5. Memoria Durable Externa:** ¿El avance y decisiones persisten en disco/Git fuera del chat?
- [ ] **6. Sensores Objetivos:** ¿Existen tests, linters y comprobaciones automáticas deterministas?
- [ ] **7. Autorización Fuera del Modelo:** ¿Las operaciones destructivas requieren aprobación explícita del arnés?
- [ ] **8. Sandboxing & Blast Radius:** ¿La ejecución corre en entorno aislado con credenciales maestras protegidas?
- [ ] **9. Trazas & Recibos de Cambio:** ¿Cada cambio deja un rastro claro de tiempo, costo, comandos y diffs?
- [ ] **10. Bucle Acotado & Escalada:** ¿Hay tope de reintentos (≤3) y ruta de escalada cuando se agota el presupuesto?

**Veredicto de Producción:**
- 🟢 8 a 10 casillas: Aprobado para autonomía supervisada.
- 🟡 5 a 7 casillas: Permitido solo en pair-programming interactivo.
- 🔴 < 5 casillas: Bloqueado. Entorno poco definido (underspecified).
```
