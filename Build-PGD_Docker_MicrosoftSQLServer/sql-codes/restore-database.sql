ALTER LOGIN [admin] WITH DEFAULT_DATABASE=[pgd_staging], DEFAULT_LANGUAGE=[Português (Brasil)], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

-- Cria novo BD para produção
RESTORE DATABASE [pgd_prod] FROM  DISK = N'/var/opt/mssql/data/pgd_staging.bak' WITH  FILE = 1,  MOVE N'pgd_staging' TO N'/var/opt/mssql/data/pgd_prod.mdf',  MOVE N'pgd_staging_log' TO N'/var/opt/mssql/data/pgd_prod_log.ldf',  NOUNLOAD,  REPLACE,  STATS = 5
GO

USE [pgd_prod]
GO
ALTER AUTHORIZATION ON DATABASE::[pgd_prod] TO [admin]
GO
