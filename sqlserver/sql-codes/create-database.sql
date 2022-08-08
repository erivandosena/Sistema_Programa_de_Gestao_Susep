-- Cria banco de dados se não existir
IF NOT EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_susep') BEGIN
    CREATE DATABASE pgd_susep
END
GO

-- Cria login se não existir
IF NOT EXISTS(SELECT principal_id FROM sys.server_principals WHERE name = 'admin') BEGIN
    CREATE LOGIN admin WITH PASSWORD = 'Sql@server2019Express'
END
GO

-- Cria o usuário para o logon especificado
USE [pgd_susep]
GO
IF NOT EXISTS(SELECT principal_id FROM sys.database_principals WHERE name = 'admin') BEGIN
    CREATE USER admin FOR LOGIN [admin]
END
GO

USE [master]
GO

-- Função do servidor para conceder ao usuário privilégios de segurança em todo servidor
ALTER SERVER ROLE [dbcreator] ADD MEMBER [admin]
GO
ALTER SERVER ROLE [serveradmin] ADD MEMBER [admin]
GO
ALTER SERVER ROLE [setupadmin] ADD MEMBER [admin]
GO

-- Permissões para o usuário admin
GRANT ALTER ON LOGIN::[admin] TO [admin] WITH GRANT OPTION
GO
GRANT CONTROL ON LOGIN::[admin] TO [admin] WITH GRANT OPTION
GO
GRANT VIEW DEFINITION ON LOGIN::[admin] TO [admin] WITH GRANT OPTION
GO
GRANT IMPERSONATE ON LOGIN::[admin] TO [admin] WITH GRANT OPTION
GO

-- Banco de dados padrão
ALTER LOGIN [admin] WITH DEFAULT_DATABASE=[pgd_susep], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

-- Associação as funções para o banco de dados
USE [pgd_susep]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [admin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [admin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [admin]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [admin]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO