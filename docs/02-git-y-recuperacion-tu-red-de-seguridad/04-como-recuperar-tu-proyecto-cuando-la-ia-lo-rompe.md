# ⏱️ Cómo Recuperar tu Proyecto cuando la IA lo Rompe

> *"El verdadero superpoder de un desarrollador asistido con IA no es no equivocarse nunca, sino tardar exactamente 3 segundos en volver al estado funcional anterior sin una gota de pánico."*

---

## 😱 La Escena Clásica del Desastre

Le pides a la IA un cambio que parecía pequeño. El modelo edita 3 archivos, la pantalla se pone en blanco y la consola se llena de 15 errores rojos en cascada.  
Le pides que lo arregle, la IA se disculpa: *"¡Mil disculpas! Mi error, aquí está la corrección..."* y ahora se rompen otros 4 archivos más.

En ese momento, muchos principiantes entran en pánico, intentan darle a `Ctrl + Z` cien veces o borran la carpeta entera.

**No hagas nada de eso. Respira hondo y usa los 3 botones de emergencia de Git:**

---

## 🚨 Los 3 Botones de Emergencia

### Botón 1: La IA rompió un archivo y aún no has hecho commit (`git restore`)
Si la IA acaba de modificar un archivo (por ejemplo, `app.js`) y el resultado es un desastre:
```bash
git restore app.js
```
*¿Qué hace?*  
Borra instantáneamente todas las modificaciones que la IA hizo sobre `app.js` y lo deja exactamente como estaba en tu último commit funcional.

Si la IA tocó varios archivos y quieres resetear **todo el proyecto** al último punto de guardado:
```bash
git restore .
```
En medio segundo, tu proyecto vuelve a estar 100% sano.

---

### Botón 2: La IA creó archivos nuevos basura que no necesitas (`git clean`)
Si la IA creó archivos temporales o carpetas innecesarias:
```bash
git clean -fd
```
*¿Qué hace?*  
Elimina todos los archivos nuevos no rastreados (*untracked*) sin tocar tus archivos legítimos guardados.

---

### Botón 3: Hiciste un commit pero te diste cuenta de que estaba roto (`git revert`)
Si guardaste un commit hace 10 minutos y luego descubriste que tenía un bug oculto:
```bash
git revert HEAD --no-edit
```
*¿Qué hace?*  
Crea un nuevo commit que deshace matemáticamente todos los cambios del commit anterior, manteniendo intacto tu historial y devolviendo la aplicación al estado seguro.

---

## 🧘 La Paz Mental del Constructor
Cuando dominas estos tres comandos:
- Le pierdes por completo el miedo a experimentar con la IA.
- Puedes pedirle refactorizaciones atrevidas o ideas complejas.
- Si funciona: `git commit`. Si falla: `git restore .`.  
**Tu proyecto nunca más volverá a quedar secuestrado por una alucinación.**
