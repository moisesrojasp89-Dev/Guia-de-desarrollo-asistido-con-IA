# 🙈 La Trampa Mortal del `display: none`

> *"Taparle los ojos al usuario con una regla de CSS no impide que sus manos toquen el dinero sobre la mesa."*

---

## 🎭 La Ilusión del "Contenido Oculto"

Este es uno de los errores más frecuentes y peligrosos que cometen quienes empiezan con desarrollo asistido por IA:

Imagina que estás construyendo una plataforma con contenido gratuito y contenido **Premium ($50/mes)**.  
Le pides a la IA:  
*«Muestra los artículos premium solo si el usuario ha pagado; si no ha pagado, ocúltalos»*.

La IA, buscando la ruta más corta, escribe lo siguiente en tu código:

```javascript
// ❌ CÓDIGO INSEGURO Y VULNERABLE GENERADO POR IA
const respuesta = await fetch('/api/todos-los-articulos-incluyendo-secretos');
const articulos = await respuesta.json();

articulos.forEach(articulo => {
  const tarjeta = document.createElement('div');
  tarjeta.innerHTML = `<h3>${articulo.titulo}</h3><p>${articulo.contenido_secreto}</p>`;
  
  // Si el usuario no ha pagado, "ocultamos" la tarjeta con CSS
  if (!usuario.haPagado) {
    tarjeta.style.display = 'none'; // 💀 VULNERABILIDAD CRÍTICA
  }
  
  document.body.appendChild(tarjeta);
});
```

---

## 💥 Por qué esto es una Catástrofe de Seguridad

1. **La descarga ya ocurrió:** El archivo JSON con todos los artículos confidenciales y secretos ya viajó por internet y está guardado en la memoria del navegador.
2. **Cualquiera lo puede ver en 2 segundos:**
   - La persona abre **F12**, va a la pestaña **Network (Red)** y lee el JSON completo en texto plano.
   - O va a la pestaña **Elements** y simplemente desmarca la casilla `display: none` en la columna de estilos. En ese instante, todo el contenido premium aparece mágicamente en su pantalla.

---

## 🛡️ La Solución Real: El Filtro se Hace en la Cocina (Backend)

La regla fundamental de la seguridad en aplicaciones web es:

> **Si un usuario no tiene permiso para ver un dato sensible, ese dato NUNCA debe incluirse en la respuesta HTTP que sale del servidor.**

```javascript
// ✅ CÓDIGO SEGURO (EN EL BACKEND / SERVIDOR)
app.get('/api/articulos', async (req, res) => {
  const usuario = req.usuarioAutenticado;
  
  if (usuario && usuario.haPagado) {
    // Si pagó, devolvemos el artículo completo con el contenido premium
    const articulos = await db.obtenerArticulosCompletos();
    return res.json(articulos);
  } else {
    // Si NO ha pagado, el backend SOLO devuelve el título y una vista previa pública
    const previews = await db.obtenerSoloTitulosYResumen();
    return res.json(previews); // El contenido_secreto JAMÁS salió del servidor
  }
});
```

En este caso, aunque el usuario abra F12, inspeccione la red o modifique todo el CSS del mundo, **el contenido confidencial nunca existió en su máquina**.
