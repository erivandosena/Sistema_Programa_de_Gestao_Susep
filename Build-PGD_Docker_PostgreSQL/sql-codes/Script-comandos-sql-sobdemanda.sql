------------------------------------------------------------------------------------
-- SQL EXTRAS
------------------------------------------------------------------------------------

-- Exemplo: Para listas as pessoas na V7
INSERT INTO "dbo"."TipoVinculo" ("tipoVinculoId", "tvnDescricao") 
VALUES 
  (1, 'Servidor');

UPDATE 
  "dbo"."Pessoa" 
SET 
  "tipoVinculoId" = 1 
WHERE 
  "pessoaId" = "pessoaId";

-- Habilita Gestores
/*
INSERT INTO dbo."CatalogoDominio"(
	"catalogoDominioId", classificacao, descricao, ativo)
	VALUES (1000, 'GestorSistema', <inserir-aqui-o-codigo-ID-da-Pessoa>, 1);
			
INSERT INTO dbo."CatalogoDominio"(
	"catalogoDominioId", classificacao, descricao, ativo)
	VALUES (1001, 'GestorSistema', <inserir-aqui-o-codigo-ID-da-Pessoa>, 1);
			
INSERT INTO dbo."CatalogoDominio"(
	"catalogoDominioId", classificacao, descricao, ativo)
	VALUES (1002, 'GestorSistema', <inserir-aqui-o-codigo-ID-da-Pessoa>, 1);
			
INSERT INTO dbo."CatalogoDominio"(
	"catalogoDominioId", classificacao, descricao, ativo)
	VALUES (1003, 'GestorSistema', <inserir-aqui-o-codigo-ID-da-Pessoa>, 1);
*/