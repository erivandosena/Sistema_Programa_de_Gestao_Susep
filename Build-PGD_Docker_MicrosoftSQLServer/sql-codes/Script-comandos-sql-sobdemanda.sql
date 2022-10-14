-- Comandos sql extras --

-- Exemplo: Para listas as pessoas na V7
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
