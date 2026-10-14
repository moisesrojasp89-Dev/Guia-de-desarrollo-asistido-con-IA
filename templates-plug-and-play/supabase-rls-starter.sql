-- ==============================================================================
-- 🔐 PLANTILLA STARTER DE ROW LEVEL SECURITY (RLS) PARA POSTGRESQL / SUPABASE
-- ==============================================================================
-- 📋 QUÉ CUBRE ESTA PLANTILLA:
-- • Aislamiento estricto entre usuarios: cada persona solo ve y edita sus datos.
-- • Restricción de inserción: ningún usuario puede crear registros a nombre de otro.
-- • Tabla privada para webhooks: cero acceso desde el frontend (clave anónima).
--
-- ⚠️ QUÉ NO CUBRE (LÍMITES Y ADVERTENCIAS CRÍTICAS):
-- • Clave Service Role: Si usas 'service_role_key' en el frontend, esta clave
--   ignora RLS por completo. Esta clave NUNCA debe salir del backend privado.
-- • Funciones SECURITY DEFINER: Las funciones creadas con este modificador se
--   ejecutan con permisos de superusuario y se saltan RLS a menos que pongas filtros.
-- • Índices de Rendimiento: RLS filtra filas pero no acelera la consulta. Es
--   obligatorio crear índices (ej: CREATE INDEX ON pedidos(usuario_id)).
-- ==============================================================================

-- 1. TABLA DE PERFILES DE USUARIO
CREATE TABLE IF NOT EXISTS perfiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL UNIQUE,
    nombre_completo TEXT,
    rol TEXT NOT NULL DEFAULT 'cliente' CHECK (rol IN ('cliente', 'administrador')),
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Habilitamos RLS obligatoriamente
ALTER TABLE perfiles ENABLE ROW LEVEL SECURITY;

-- Política 1: Cualquier usuario autenticado puede leer su propio perfil
CREATE POLICY "Los usuarios pueden ver su propio perfil"
ON perfiles
FOR SELECT
USING (auth.uid() = id);

-- Política 2: Los usuarios pueden actualizar únicamente su propio perfil
CREATE POLICY "Los usuarios pueden actualizar su propio perfil"
ON perfiles
FOR UPDATE
USING (auth.uid() = id)
WITH CHECK (auth.uid() = id);


-- ==============================================================================
-- 2. TABLA DE PEDIDOS / TRANSACCIONES
-- ==============================================================================
CREATE TABLE IF NOT EXISTS pedidos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id UUID NOT NULL REFERENCES perfiles(id) ON DELETE CASCADE,
    titulo TEXT NOT NULL,
    monto_centavos INTEGER NOT NULL CHECK (monto_centavos > 0),
    estado TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'pagado', 'cancelado')),
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Índice esencial para que el filtrado por RLS sea sub-milisegundo
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
-- 3. TABLA DE IDEMPOTENCIA (Para Webhooks de Stripe / Meta / WhatsApp)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS eventos_procesados (
    id TEXT PRIMARY KEY, -- wamid de WhatsApp o evt_id de Stripe
    tipo_evento TEXT NOT NULL,
    procesado_en TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

ALTER TABLE eventos_procesados ENABLE ROW LEVEL SECURITY;

-- Esta tabla NO tiene políticas para 'anon' ni 'authenticated'.
-- Por definición en PostgreSQL, RLS activado sin políticas = ACCESO DENEGADO (0 filas)
-- para cualquier usuario que intente consultarla desde el navegador con la tecla F12.
-- Solo el backend privado con 'service_role' puede insertar y leer aquí.


-- ==============================================================================
-- 🧪 SUITE DE PRUEBAS DE SEGURIDAD (CÓMO COMPROBAR QUE FUNCIONA)
-- ==============================================================================
-- Copia y corre estas pruebas en el SQL Editor de Supabase para validar que
-- las restricciones no son ilusorias:

/*
-- PRUEBA NEGATIVA 1: Usuario Anónimo (Sin login) intenta leer pedidos
-- Resultado esperado: 0 filas devueltas (bloqueo total).
SET ROLE anon;
SELECT * FROM pedidos; 
-- Retorna: 0 filas.

-- PRUEBA NEGATIVA 2: Usuario A intenta leer los pedidos del Usuario B
-- Supongamos que simulamos ser el usuario '11111111-1111-1111-1111-111111111111'
SET ROLE authenticated;
SET request.jwt.claim.sub = '11111111-1111-1111-1111-111111111111';

-- Intenta consultar un pedido que pertenece a otro ID diferente:
SELECT * FROM pedidos WHERE usuario_id = '22222222-2222-2222-2222-222222222222';
-- Resultado esperado: 0 filas devueltas (bloqueado por RLS).

-- PRUEBA NEGATIVA 3: Usuario A intenta suplantar identidad al insertar
INSERT INTO pedidos (usuario_id, titulo, monto_centavos)
VALUES ('22222222-2222-2222-2222-222222222222', 'Hack de pedido', 1000);
-- Resultado esperado: ERROR: new row violates row-level security policy for table "pedidos"

-- Restaurar permisos de superusuario para seguir administrando:
RESET ROLE;
*/
