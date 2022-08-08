-- Comandos sql extras --

-- Exemplo:
INSERT INTO [dbo].[TipoVinculo]
           ([tipoVinculoId]
           ,[tvnDescricao])
     VALUES
           (1, 'Servidor')
GO
UPDATE [dbo].[Pessoa]
      SET [tipoVinculoId] = 1
WHERE [pessoaId] = [pessoaId]
GO
--

-- Scrips carga de dados, pessoas, usuarios AD, etc...