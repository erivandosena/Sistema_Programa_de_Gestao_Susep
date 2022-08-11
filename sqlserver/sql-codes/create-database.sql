-- Cria banco de dados se não existir
IF NOT EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_susep') BEGIN
    CREATE DATABASE pgd_susep
    CREATE DATABASE pgd_staging
    CREATE DATABASE pgd_train
END
GO

-- Cria login se não existir
IF NOT EXISTS(SELECT principal_id FROM sys.server_principals WHERE name = 'admin') BEGIN
    CREATE LOGIN [admin] WITH PASSWORD = 'Sql@server2019Express'
    -- Função do servidor para conceder ao usuário privilégios de segurança em todo servidor
    ALTER SERVER ROLE [dbcreator] ADD MEMBER [admin]
    ALTER SERVER ROLE [serveradmin] ADD MEMBER [admin]
    ALTER SERVER ROLE [setupadmin] ADD MEMBER [admin]
END
GO

USE [pgd_susep]
GO
-- Criação e mapeamento do usuário para o logon
CREATE USER [admin] FOR LOGIN [admin]
GO
-- Associação à função de banco de dados
ALTER USER [admin] WITH DEFAULT_SCHEMA=[dbo]
ALTER ROLE [db_backupoperator] ADD MEMBER [admin]
ALTER ROLE [db_owner] ADD MEMBER [admin]
ALTER ROLE [db_datareader] ADD MEMBER [admin]
ALTER ROLE [db_datawriter] ADD MEMBER [admin]
GO
-- Banco de dados padrão do logon
ALTER LOGIN [admin] WITH DEFAULT_DATABASE=[pgd_susep], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO