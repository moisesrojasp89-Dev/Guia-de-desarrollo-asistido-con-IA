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

## ⚖️ El Principio de Mínimo Privilegio

La regla de oro de la seguridad en bases de datos es:  
**Nunca le des a un componente más permisos de los estrictamente necesarios para hacer su trabajo.**

1. **Lectura Pública:** Si tienes un blog, cualquiera puede leer los artículos (`FOR SELECT USING (true)`).
2. **Creación con Identidad:** Al crear un comentario, el autor no puede fingir ser otro usuario (`WITH CHECK (auth.uid() = usuario_id)`).
3. **Escritura Administrativa:** Solo usuarios con el rol `'admin'` pueden cambiar el precio de un producto o eliminar un registro.

Cuando activas RLS desde el día 1, duermes con la absoluta tranquilidad de que tus datos están blindados a nivel de motor.
