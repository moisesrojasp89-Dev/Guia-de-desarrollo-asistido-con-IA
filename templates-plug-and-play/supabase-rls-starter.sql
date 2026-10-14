-- ==============================================================================
-- 🔐 MODELO DIDÁCTICO DE REFERENCIA: ROW LEVEL SECURITY (RLS) EN POSTGRESQL
-- ==============================================================================
-- ⚠️ AVISO LEGAL Y TÉCNICO OBLIGATORIO — LEER ANTES DE USAR
-- ==============================================================================
-- 1. ESTE ARCHIVO ES UN MODELO DIDÁCTICO DE APRENDIZAJE, NO UNA PLANTILLA
--    GENÉRICA PARA COPIAR Y PEGAR DIRECTAMENTE EN UNA BASE DE DATOS DE PRODUCCIÓN.
--
-- 2. Cada aplicación tiene un esquema de datos, nombres de tablas, relaciones
--    y reglas de negocio únicos. Ejecutar scripts SQL a ciegas en producción
--    puede provocar:
--    • Pérdida irreparable de datos por borrados accidentales o conflictos de claves.
--    • Bloqueo inmediato del acceso a todos tus usuarios por políticas restrictivas mal diseñadas.
--    • Fugas masivas de privacidad si tus columnas de usuario no coinciden exactamente.
--
-- 3. EXENCIÓN DE RESPONSABILIDAD:
--    Los autores y colaboradores de este repositorio no asumen responsabilidad
--    alguna por pérdidas de datos, incidentes de seguridad, caídas de servicio
--    o daños directos o indirectos derivados del uso, copia o adaptación de
--    este archivo. Es tu responsabilidad estricta auditar, comprender y probar
--    cada instrucción antes de tocar datos reales.
--
-- 4. REGLA SAGRADA DEL DESARROLLADOR:
--    NUNCA ejecutes este ni ningún otro script SQL en una base de datos con usuarios
--    reales sin haberlo probado previamente en un entorno local aislado (como
--    PostgreSQL en Docker) o en un proyecto de pruebas descartable.
-- ==============================================================================
-- 📋 CONCEPTOS ILUSTRADOS EN ESTE MODELO DIDÁCTICO:
-- • Aislamiento estricto entre usuarios: cada persona solo ve y edita sus filas.
-- • Restricción de inserción: ningún usuario puede crear registros a nombre de otro.
-- • Tabla privada para webhooks: cero acceso desde el frontend (clave anónima).
--
-- ⚠️ LÍMITES CRÍTICOS QUE DEBES ENTENDER:
-- • Clave Service Role: Si expones la 'service_role_key' en el frontend (navegador),
--   esta clave ignora RLS por completo. La clave de servicio NUNCA debe salir del backend.
-- • Funciones SECURITY DEFINER: Se ejecutan con permisos de superusuario y se saltan RLS
--   a menos que agregues filtros manuales.
-- • Índices: RLS filtra filas pero no las indexa. Siempre crea índices en tus foreign keys.
-- ==============================================================================

-- 1. EJEMPLO: TABLA DE PERFILES DE USUARIO
CREATE TABLE IF NOT EXISTS perfiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL UNIQUE,
    nombre_completo TEXT,
    rol TEXT NOT NULL DEFAULT 'cliente' CHECK (rol IN ('cliente', 'administrador')),
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Habilitamos RLS obligatoriamente en la tabla
ALTER TABLE perfiles ENABLE ROW LEVEL SECURITY;

-- Política Didáctica 1: Cualquier usuario autenticado puede leer ÚNICAMENTE su propio perfil
CREATE POLICY "Los usuarios pueden ver su propio perfil"
ON perfiles
FOR SELECT
USING (auth.uid() = id);

-- Política Didáctica 2: Los usuarios pueden actualizar ÚNICAMENTE su propio perfil
CREATE POLICY "Los usuarios pueden actualizar su propio perfil"
ON perfiles
FOR UPDATE
USING (auth.uid() = id)
WITH CHECK (auth.uid() = id);


-- ==============================================================================
-- 2. EJEMPLO: TABLA DE PEDIDOS / TRANSACCIONES
-- ==============================================================================
CREATE TABLE IF NOT EXISTS pedidos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id UUID NOT NULL REFERENCES perfiles(id) ON DELETE CASCADE,
    titulo TEXT NOT NULL,
    monto_centavos INTEGER NOT NULL CHECK (monto_centavos > 0),
    estado TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'pagado', 'cancelado')),
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Índice esencial para que el filtrado por RLS sea sub-milisegundo y no ahogue la CPU
CREATE INDEX IF NOT EXISTS idx_pedidos_usuario_id ON pedidos(usuario_id);

ALTER TABLE pedidos ENABLE ROW LEVEL SECURITY;

-- Política: El cliente solo puede ver sus propios pedidos
CREATE POLICY "Clientes solo ven sus propios pedidos"
ON pedidos
FOR SELECT
USING (auth.uid() = usuario_id);

-- Política: Al crear un pedido, el usuario_id debe coincidir obligatoriamente con el usuario conectado
CREATE POLICY "Clientes solo crean pedidos para sí mismos"
ON pedidos
FOR INSERT
WITH CHECK (auth.uid() = usuario_id);


-- ==============================================================================
-- 3. EJEMPLO: TABLA PRIVADA DE IDEMPOTENCIA (Para Webhooks de Stripe / Meta)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS eventos_procesados (
    id TEXT PRIMARY KEY, -- wamid de WhatsApp o evt_id de Stripe
    tipo_evento TEXT NOT NULL,
    procesado_en TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

ALTER TABLE eventos_procesados ENABLE ROW LEVEL SECURITY;

-- Esta tabla NO tiene políticas para 'anon' ni 'authenticated'.
-- En PostgreSQL, RLS activado sin políticas = ACCESO TOTALMENTE DENEGADO (0 filas)
-- para cualquier usuario que intente consultarla desde el navegador o la tecla F12.
-- Solo tu backend seguro con 'service_role' tiene autorización para leer o insertar aquí.


-- ==============================================================================
-- 🧪 SUITE DE PRUEBAS DE SEGURIDAD (CÓMO VERIFICAR EN ENTORNO DE PRUEBAS)
-- ==============================================================================
-- Ejecuta estas pruebas en un proyecto de prueba descartable para comprobar
-- que el aislamiento no es ilusorio:

/*
-- PRUEBA NEGATIVA 1: Usuario Anónimo (Sin login) intenta leer pedidos
-- Resultado esperado: 0 filas devueltas (bloqueo total).
SET ROLE anon;
SELECT * FROM pedidos; 
-- Retorna: 0 filas.

-- PRUEBA NEGATIVA 2: Usuario A intenta leer los pedidos del Usuario B
SET ROLE authenticated;
SET request.jwt.claim.sub = '11111111-1111-1111-1111-111111111111';

-- Intenta consultar un pedido que pertenece a otro ID diferente:
SELECT * FROM pedidos WHERE usuario_id = '22222222-2222-2222-2222-222222222222';
-- Resultado esperado: 0 filas devueltas (bloqueado por RLS).

-- PRUEBA NEGATIVA 3: Usuario A intenta suplantar identidad al insertar
INSERT INTO pedidos (usuario_id, titulo, monto_centavos)
VALUES ('22222222-2222-2222-2222-222222222222', 'Hack de pedido', 1000);
-- Resultado esperado: ERROR: new row violates row-level security policy for table "pedidos"

-- Restaurar permisos de superusuario para seguir administrando tu base de pruebas:
RESET ROLE;
*/
