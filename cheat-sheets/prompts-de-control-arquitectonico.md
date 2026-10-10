# 💬 Prompts de Control Arquitectónico

> *"Fórmulas probadas en la trinchera para frenar atajos destructivos de la IA y exigir soluciones de nivel profesional."*

---

## 🛑 1. El Freno de Emergencia (Cuando la IA empieza a disculparse y a dar vueltas)

Copia y pega esto cuando la IA entre en un bucle de disculpas vacías:

```text
DETENTE. Prohibido disculparse o prometer mejoras emocionales.
No toques ningún archivo de código todavía.

Quiero un diagnóstico de ingeniería estricto en este formato:
1. SÍNTOMA: ¿Qué falló exactamente?
2. CAUSA RAÍZ (5-WHYS): ¿Por qué ocurrió el fallo en el nivel más profundo?
3. ARCHIVOS AFECTADOS: ¿Qué módulos específicos necesitan ajuste?
4. PLAN MÍNIMO: ¿Cuál es el cambio mínimo quirúrgico necesario para resolverlo sin romper nada más?

Espera mi visto bueno antes de modificar cualquier línea.
```

---

## 📐 2. El Prompt de Entrega del `SPEC.md` (Inicio de Proyecto o Módulo)

```text
He redactado el archivo SPEC.md en este repositorio. 
Tu tarea en este momento NO es programar ni generar código.

Por favor haz lo siguiente:
1. Resume en 3 viñetas el objetivo central del sistema y la lista explícita de cosas que están FUERA DE ALCANCE (Anti-Scope).
2. Revisa el modelo de datos propuesto y confirma si detectas alguna inconsistencia con el flujo del usuario.
3. Propón únicamente el árbol de carpetas y archivos base que necesitaremos.

Espera mi confirmación para el siguiente paso.
```

---

## 🔍 3. El Modo "Abogado del Diablo" (Auditoría de Seguridad y Resiliencia)

```text
Actúa como un Auditor de Seguridad e Infraestructura implacable (Red Team).
Examina el código que acabamos de implementar buscando:
1. Posibles fugas de claves o secretos visibles desde el navegador (Prueba F12).
2. Vulnerabilidades en webhooks: ¿Estamos validando firmas HMAC e idempotencia contra reintentos?
3. Estados inconsistentes: ¿Qué ocurre si la base de datos se corta a mitad de la operación?
4. Casos límite en interfaz: ¿Qué ve el usuario si la lista de datos viene vacía o con error?

Entrega un reporte ordenado por nivel de criticidad (Crítico, Medio, Menor).
```

---

## ✂️ 4. El Prompt Anti-Monolito (Refactorización Segura)

```text
El archivo [nombre_archivo] ha crecido demasiado y necesita ser modularizado.
Reglas innegociables para este refactor:
1. No cambies la lógica ni el comportamiento visible para el usuario.
2. Divide el archivo en módulos de menos de 150 líneas organizados por responsabilidad (rutas, servicios, base de datos).
3. Asegura pureza de importación (Zero Side-Effects): importar un módulo no debe ejecutar acciones de red.
4. Muestra primero el mapa de nuevos archivos propuesto antes de escribir código.
```
