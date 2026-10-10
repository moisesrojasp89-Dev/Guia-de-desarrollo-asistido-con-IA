# ⚖️ Modelos Modestos vs. Modelos de Frontera

> *"Usar un modelo masivo de frontera para corregir una falta de ortografía en HTML es como contratar un camión de bomberos para regar una maceta."*

---

## 🏎️ El Espectro de Modelos en la Actualidad

En el ecosistema de Inteligencia Artificial actual existen dos grandes familias de modelos:

```
[ Modelos Ligeros y Rápidos ]  ◄───────────────────────────►  [ Modelos de Frontera / Razonamiento ]
   (Flash-Lite, Haiku, GPT-4o-mini)                               (Claude 3.7 Sonnet, GPT-o1, Opus)
   • Latencia: < 400ms                                           • Latencia: 3s – 15s
   • Costo: Fracciones de centavo ($0.05 / 1M)                    • Costo: 10x a 30x más caro ($3 - $15 / 1M)
   • Fortaleza: Velocidad, formato, regex                         • Fortaleza: Arquitectura, debugging complejo
```

---

## 🎯 ¿Para qué sirve cada uno?

### ⚡ Cuándo Usar Modelos Modestos / Rápidos (Gemini Flash, Haiku, Mini)
1. **Extracción y Formato de Datos:** Convertir un texto o un CSV desordenado en un objeto JSON limpio.
2. **Generación de Pruebas Unitarias Sencillas:** Escribir tests para funciones que suman valores o validan correos electrónicos.
3. **Documentación y Comentarios:** Redactar la explicación de una función existente o generar un changelog.
4. **Traducciones y Micro-textos:** Ajustar textos en interfaces de usuario.
5. **Autocompletado de Código en Tiempo Real:** Sugerir la siguiente línea mientras estás tecleando.

---

### 🧠 Cuándo Usar Modelos de Frontera y Razonamiento (Sonnet, Opus, o1/o3)
1. **El Paso Cero (Diseño Inicial):** Redactar y auditar el archivo `SPEC.md` inicial.
2. **Auditorías de Seguridad:** Analizar si las políticas de Row Level Security (RLS) en Supabase tienen alguna brecha de fuga de datos.
3. **Depuración de Errores Inexplicables:** Cuando un bug lleva 4 horas sin resolverse y cruza tres sistemas diferentes (frontend, base de datos y webhook externo).
4. **Refactorización de Archivos Grandes:** Partir un archivo espagueti de 1,500 líneas en 5 módulos desacoplados sin romper las dependencias.

---

## 💰 La Regla del Presupuesto Inteligente
Si estás utilizando las APIs de los modelos de pago por uso:
- Realizar el 80% de tus consultas cotidianas con modelos ligeros te permite **ahorrar entre un 85% y un 95% de tu presupuesto mensual**, reservando los créditos de los modelos pesados exclusivamente para momentos de decisión crítica.
