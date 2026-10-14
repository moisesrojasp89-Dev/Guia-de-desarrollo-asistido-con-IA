# 🔒 Seguridad en la Base de Datos: Row Level Security (RLS) y Mínimo Privilegio

> *"Tener la llave de la puerta del hotel no te autoriza a entrar a las habitaciones de los demás huéspedes ni a la bóveda de administración."*

---

## 🏨 La Analogía del Hotel y la Llave Electrónica

Imagina un hotel:
- Cada huésped recibe una tarjeta electrónica de acceso.
- Cuando pasas la tarjeta por el ascensor y por tu habitación (Habitación 302), la puerta se abre.
- Pero si intentas abrir la habitación 304, la cerradura permanece cerrada.

En una base de datos tradicional sin protección (o mal configurada por la IA):
- Todo usuario que tiene una conexión a la base de datos puede escribir `SELECT * FROM facturas;` y **descargar las facturas de todos los clientes de la empresa**.
- Esto es una catástrofe de privacidad.

---

## 🛡️ ¿Qué es Row Level Security (RLS)?

**Row Level Security (Seguridad a Nivel de Fila)** es una característica nativa de motores de base de datos como **PostgreSQL** (utilizado por Supabase, Neon y la mayoría de nubes modernas).

En lugar de confiar en que tu código de JavaScript siempre recuerde poner `WHERE usuario_id = mi_id`, **la base de datos misma impone la regla de forma inquebrantable**:

```sql
-- 1. Activamos la seguridad estricta en la tabla
ALTER TABLE pedidos ENABLE ROW LEVEL SECURITY;

-- 2. Creamos la regla: "Solo puedes ver los pedidos que te pertenecen"
CREATE POLICY "Los usuarios solo ven sus propios pedidos"
ON pedidos
FOR SELECT
USING (auth.uid() = usuario_id);
```

### ¿Qué ocurre ahora?
Incluso si un usuario malicioso abre la consola del navegador con F12 y ejecuta una consulta intentando pedir todas las órdenes del sistema, el motor de PostgreSQL revisa la regla y **solo le devuelve las filas donde su ID coincide con el usuario autenticado**. Las órdenes de los demás clientes simplemente no existen para él.

---

## ⚠️ El Peligro de Copiar Scripts SQL y la Alucinación de la IA

Hay una diferencia fundamental entre equivocarse en JavaScript/Python y equivocarse en SQL:
* En **JavaScript/Python**, un error suele arrojar una excepción (`ReferenceError`, `SyntaxError`) y el programa simplemente se detiene.
* En **SQL**, un error puede **destruir permanentemente datos en disco**, bloquear el acceso a todos los usuarios legítimos o dejar la base de datos abierta al mundo **sin arrojar ningún error visible en pantalla**.

> [!CAUTION]
> **Nunca trates los scripts SQL como piezas mágicas de "copiar y pegar a ciegas".**  
> Cada aplicación tiene modelos de datos, relaciones de claves y nombres de columnas únicos. Copiar un script de internet o de una IA sin auditarlo puede arruinar tu proyecto en segundos.

### Las 4 Trampas Silenciosas que la IA Suele Cometer en SQL:

1. **La Falsa Autorización en RLS (`auth.uid() IS NOT NULL`):**  
   Muchos modelos de IA intentan "hacer que el código funcione" escribiendo:
   ```sql
   -- ❌ TRAMPA MORTAL: Esto solo verifica si el usuario inició sesión.
   -- ¡Le permite a cualquier cliente registrado descargar las facturas de TODOS los demás!
   USING (auth.uid() IS NOT NULL);
   
   -- ✔️ REGLA CORRECTA: Verifica propiedad estricta de la fila.
   USING (auth.uid() = usuario_id);
   ```
2. **El Olvido de Activar RLS (`ENABLE ROW LEVEL SECURITY`):**  
   Si creas 10 políticas con `CREATE POLICY`, pero olvidas ejecutar `ALTER TABLE tu_tabla ENABLE ROW LEVEL SECURITY;`, **PostgreSQL ignora todas las políticas** y la tabla sigue siendo 100% pública.
3. **Sentencias de Modificación sin Filtro (`UPDATE` / `DELETE` sin `WHERE`):**  
   Al pedirle a la IA una corrección o actualización de un registro, a veces propone sentencias que, si no tienen un `WHERE` estricto, modifican o borran la tabla entera.
4. **Destrucción de Columnas sin Respaldo (`DROP COLUMN`):**  
   Si le pides a la IA refactorizar un campo, suele sugerir borrar la columna vieja directamente, destruyendo los datos históricos de tus usuarios existentes.

---

## 📋 Protocolo de Seguridad del Ingeniero Asistido por IA

Antes de ejecutar cualquier script SQL en tu proyecto:

1. **El Entorno Aislado (Sandbox Obligatorio):**  
   NUNCA ejecutes un script SQL directamente en tu base de datos de producción con clientes reales. Pruébalo siempre primero en un contenedor local de Docker o en un proyecto de prueba secundario y descartable.
2. **Copia de Seguridad Previa (Dump):**  
   Antes de correr cualquier migración o script manual, descarga un respaldo completo de tu base de datos (`pg_dump` o el botón de backup de tu proveedor). Si algo falla, puedes restaurar en minutos.
3. **Ejecuta Pruebas Negativas:**  
   No te limites a verificar que tu usuario administrador puede ver sus datos. Simula ser un usuario anónimo o un cliente ajeno y **confirma activamente que el motor de base de datos le bloquea el acceso**.

> 💡 *Para ver un modelo didáctico de cómo estructurar estas reglas y pruebas negativas, consulta el [Modelo de Referencia RLS](file:///c:/Users/indatech/Desktop/Manual%20para%20Desarrollo%20Asistido%20con%20IA/templates-plug-and-play/supabase-rls-starter.sql).*
