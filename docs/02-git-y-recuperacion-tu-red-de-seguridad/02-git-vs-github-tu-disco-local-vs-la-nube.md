# ☁️ Git vs. GitHub: Tu Disco Local vs. La Nube

> *"Confundir Git con GitHub es como confundir el motor de tu coche con la autopista por la que viajas."*

---

## 🏎️ La Gran Diferencia

Muchos principiantes creen que Git y GitHub son la misma cosa con dos nombres distintos. Nada más lejos de la realidad:

```text
┌────────────────────────────────────────────────────────┐
│                        GIT                             │
│   • Es una herramienta gratuita instalada en tu PC.    │
│   • Funciona 100% desconectada de internet (en avión). │
│   • Lleva el historial de cambios en tu disco duro.    │
└────────────────────────────────────────────────────────┘
                           │
                           ▼ (Se conecta mediante 'git push')
┌────────────────────────────────────────────────────────┐
│                       GITHUB                           │
│   • Es una página web / plataforma en la nube.         │
│   • Guarda una copia remota de tu repositorio Git.     │
│   • Permite compartir código, colaborar y correr CI/CD. │
└────────────────────────────────────────────────────────┘
```

---

## 🔒 ¿Por qué es vital tener ambos?

### 1. Git en Local (Tu Cinturón de Seguridad Inmediato)
- Cuando le pides código a Cursor, Claude o Antigravity, **Git trabaja en tu propia máquina**.
- Si la IA rompe tu archivo, no necesitas internet ni abrir ninguna página web para deshacer el cambio: lo resuelves en tu terminal en medio segundo.

### 2. GitHub en la Nube (Tu Copia de Seguridad y Escaparate Público)
- Si tu laptop se moja, te la roban o se daña el disco duro: todo tu trabajo sigue a salvo en GitHub.
- Te permite mostrar tu código a la comunidad, invitar a colaboradores y conectar servicios como Vercel o GitHub Actions para inspeccionar la calidad en cada entrega.

---

## 🪄 Los 2 Comandos que Conectan tu Máquina con la Nube

1. **`git push` (Empujar hacia arriba):**  
   Toma los commits que hiciste en tu computadora y sube una copia idéntica a tu repositorio en GitHub.
2. **`git pull` (Traer hacia abajo):**  
   Si hiciste cambios desde otra computadora o un colaborador subió una mejora, los descarga a tu máquina local.
