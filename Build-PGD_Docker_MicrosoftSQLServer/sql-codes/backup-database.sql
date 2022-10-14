-- Início backup pgd_staging
IF EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_staging') BEGIN
    BACKUP DATABASE [pgd_staging] TO  DISK = N'/var/opt/mssql/data/pgd_staging.bak' WITH  DESCRIPTION = N'Backup após start do container', NOFORMAT, INIT,  NAME = N'pgd_staging-backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
END
GO
-- Verificação backup pgd_staging
IF EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_staging') BEGIN
    declare @backupSetId as int
    select @backupSetId = position from msdb..backupset where database_name=N'pgd_staging' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'pgd_staging' )
    if @backupSetId is null begin raiserror(N'Falha na verificação. Informações de backup do banco de dados ''pgd_staging'' não encontradas.', 16, 1) end
    RESTORE VERIFYONLY FROM  DISK = N'/var/opt/mssql/data/pgd_staging.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
END
GO
-- Fim

-- Início backup pgd_prod
IF EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_prod') BEGIN
    BACKUP DATABASE [pgd_prod] TO  DISK = N'/var/opt/mssql/data/pgd_prod.bak' WITH  DESCRIPTION = N'Backup após start do container', NOFORMAT, INIT,  NAME = N'pgd_prod-backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
END
GO
-- Verificação backup pgd_prod
IF EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_prod') BEGIN
    declare @backupSetId as int
    select @backupSetId = position from msdb..backupset where database_name=N'pgd_prod' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'pgd_prod' )
    if @backupSetId is null begin raiserror(N'Falha na verificação. Informações de backup do banco de dados ''pgd_prod'' não encontradas.', 16, 1) end
    RESTORE VERIFYONLY FROM  DISK = N'/var/opt/mssql/data/pgd_prod.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
END
GO
-- Fim
