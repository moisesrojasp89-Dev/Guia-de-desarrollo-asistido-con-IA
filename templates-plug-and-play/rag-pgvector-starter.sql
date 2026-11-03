-- ============================================================================
-- 📚 PLANTILLA PLUG & PLAY: RAG SEGURO CON PGVECTOR Y RLS (SUPABASE / POSTGRES)
-- ============================================================================
-- Propósito: Convertir tu base de datos PostgreSQL o Supabase en un buscador
-- semántico vectorial para PDFs y documentos privados, garantizando que cada
-- usuario SOLO pueda buscar dentro de sus propios archivos (Aislamiento RLS).
-- ============================================================================

-- 1. Activar la extensión vectorial nativa de PostgreSQL
CREATE EXTENSION IF NOT EXISTS vector;

-- 2. Crear la tabla de fragmentos de documentos (Chunks)
CREATE TABLE IF NOT EXISTS public.document_chunks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  document_title TEXT NOT NULL,
  page_number INTEGER DEFAULT 1,
  content TEXT NOT NULL,
  metadata JSONB DEFAULT '{}'::jsonb,
  -- 1536 dimensiones (Estándar para text-embedding-3-small; usa 768 si usas Gemini/Nomic)
  embedding vector(1536) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 3. Crear índice HNSW para que la búsqueda sea instantánea incluso con miles de PDFs
CREATE INDEX IF NOT EXISTS idx_document_chunks_embedding 
ON public.document_chunks 
USING hnsw (embedding vector_cosine_ops);

CREATE INDEX IF NOT EXISTS idx_document_chunks_user_id 
ON public.document_chunks (user_id);

-- ============================================================================
-- 4. CANDADO DE CIBERSEGURIDAD: ROW LEVEL SECURITY (RLS) ESTRICTO
-- ============================================================================
ALTER TABLE public.document_chunks ENABLE ROW LEVEL SECURITY;

-- Política de Lectura: El usuario SOLO ve los fragmentos que le pertenecen
CREATE POLICY "Usuarios solo leen sus propios documentos"
ON public.document_chunks
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

-- Política de Inserción: El usuario SOLO puede subir fragmentos a su propio nombre
CREATE POLICY "Usuarios solo insertan sus propios documentos"
ON public.document_chunks
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

-- Política de Borrado: El usuario SOLO puede borrar sus propios documentos
CREATE POLICY "Usuarios solo borran sus propios documentos"
ON public.document_chunks
FOR DELETE
TO authenticated
USING (auth.uid() = user_id);

-- ============================================================================
-- 5. FUNCIÓN DE BÚSQUEDA SEMÁNTICA CON UMBRAL ANTI-ALUCINACIÓN
-- ============================================================================
CREATE OR REPLACE FUNCTION public.buscar_mis_documentos(
  query_embedding vector(1536),
  umbral_similitud FLOAT DEFAULT 0.72,
  limite_resultados INT DEFAULT 5
)
RETURNS TABLE (
  id UUID,
  document_title TEXT,
  page_number INTEGER,
  content TEXT,
  similitud FLOAT
)
LANGUAGE plpgsql
SECURITY INVOKER -- Respeta automáticamente las políticas RLS del usuario autenticado
AS $$
BEGIN
  RETURN QUERY
  SELECT
    dc.id,
    dc.document_title,
    dc.page_number,
    dc.content,
    1 - (dc.embedding <=> query_embedding) AS similitud
  FROM public.document_chunks dc
  WHERE dc.user_id = auth.uid() -- Candado explícito adicional Anti-IDOR
    AND 1 - (dc.embedding <=> query_embedding) >= umbral_similitud
  ORDER BY dc.embedding <=> query_embedding ASC
  LIMIT limite_resultados;
END;
$$;
