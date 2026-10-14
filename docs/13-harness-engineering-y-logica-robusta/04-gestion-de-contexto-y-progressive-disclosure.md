# 📚 Gestión de Contexto y Progressive Disclosure

> *"Meter 50 archivos de código en la ventana de chat esperando que la IA entienda tu proyecto es como lanzarle una enciclopedia entera a la cara a alguien para pedirle la hora."*

---

## 🌫️ El Problema del "Ruido de Contexto" (Baja SNR)

La relación señal-ruido del contexto define la calidad de la respuesta de cualquier modelo:

$$\text{Calidad de Respuesta} \propto \frac{\text{Tokens Relevantes para la Tarea Actual (Señal)}}{\text{Tokens Totales en la Ventana de Chat (Ruido)}}$$

Cuando saturas al modelo con tu proyecto entero:
- Se produce el fenómeno de **Pérdida en el Medio (Lost in the Middle)**: el modelo atiende con fuerza al principio y al final del texto, pero olvida las reglas enterradas en la mitad.
- El costo de tokens se multiplica por 10.
- La latencia aumenta de 1 segundo a 15 segundos.

---

## 🪟 La Solución: Revelación Progresiva (Progressive Disclosure)

En lugar de entregarle todo de golpe, utiliza una estrategia de **Revelación Progresiva en 3 Niveles**:

```text
Nivel 1: El Índice General (Siempre visible)
├── README.md / SPEC.md resumido (Objetivo del sistema y nombres de módulos).

Nivel 2: Los Contratos de Interfaz (Bajo demanda)
├── Solo los archivos de tipos o esquemas de datos del módulo a trabajar.

Nivel 3: La Implementación Concreta (Solo para la tarea activa)
└── El único archivo .js o .py que se va a editar en esta sesión.
```

---

## 🛠️ Cómo Aplicarlo en Editores Modernos (Cursor, Windsurf, Claude Code)
1. **Usa menciones específicas:** En lugar de `@codebase` para todo, usa `@archivo_concreto.ts` y `@interfaz.ts`.
2. **Cierra sesiones largas:** Si una conversación ya tiene más de 20 mensajes de ida y vuelta, **ábrela de nuevo**. El historial acumulado contiene errores viejos y discusiones superadas que solo confunden al modelo.
3. **Mantén tus archivos pequeños:** Si un archivo tiene 200 líneas, la IA lo procesa en segundos con perfección. Si tiene 3,000 líneas, se pierde en los detalles.
