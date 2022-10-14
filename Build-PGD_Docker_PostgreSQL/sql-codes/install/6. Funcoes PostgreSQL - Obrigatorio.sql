-- Função IIF for PGD e PostgreSQL
-- By Erivando Sena<erivandosena@gmail.com>

CREATE 
OR REPLACE FUNCTION "ProgramaGestao"."IIF"(
  condition boolean, 
  -- IF     
  true_result anyelement, 
  -- THEN    
  false_result anyelement 
  -- ELSE
  ) RETURNS anyelement AS $f$ 
SELECT 
  CASE WHEN condition THEN true_result ELSE false_result END$f$ LANGUAGE SQL IMMUTABLE;
  
CREATE 
OR REPLACE FUNCTION "dbo"."IIF"(
  condition boolean, 
  -- IF    
  true_result anyelement, 
  -- THEN    
  false_result anyelement 
  -- ELSE
  ) RETURNS anyelement AS $f$ 
SELECT 
  CASE WHEN condition THEN true_result ELSE false_result END$f$ LANGUAGE SQL IMMUTABLE;
  
COMMENT ON FUNCTION dbo."IIF"(boolean, anyelement, anyelement)
    IS 'Uso:
        SELECT dbo."IIF"(0=1, 1, 2);
        SELECT dbo."IIF"(0=1, ''sim''::text, ''nao'');';
		
COMMENT ON FUNCTION "ProgramaGestao"."IIF"(boolean, anyelement, anyelement)
    IS 'Uso:
        SELECT dbo."IIF"(0=1, 1, 2);
        SELECT dbo."IIF"(0=1, ''sim''::text, ''nao'');';
