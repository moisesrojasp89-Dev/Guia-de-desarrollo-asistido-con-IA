-- ==============================================================================
-- 🔐 PLANTILLA STARTER DE ROW LEVEL SECURITY (RLS) PARA POSTGRESQL / SUPABASE
-- ==============================================================================
-- Filosofía: Aislamiento estricto multi-usuario y principio de mínimo privilegio.
-- Ningún usuario debe poder leer, modificar ni borrar datos de otro usuario.
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

-- Esta tabla solo debe ser accesible por el backend interno (Service Role).
-- Al no crear ninguna política para 'anon' o 'authenticated', nadie desde el navegador
-- puede leerla ni alterarla con la tecla F12.
