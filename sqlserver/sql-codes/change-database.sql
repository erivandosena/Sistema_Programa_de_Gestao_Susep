-- Início backup pgd_susep
IF EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_susep') BEGIN
    BACKUP DATABASE [pgd_susep] TO  DISK = N'/var/opt/mssql/data/pgd_susep.bak' WITH  DESCRIPTION = N'Backup após start do container', NOFORMAT, INIT,  NAME = N'pgd_susep-backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
END
GO
-- Verificação backup pgd_susep
IF EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_susep') BEGIN
    declare @backupSetId as int
    select @backupSetId = position from msdb..backupset where database_name=N'pgd_susep' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'pgd_susep' )
    if @backupSetId is null begin raiserror(N'Falha na verificação. Informações de backup do banco de dados ''pgd_susep'' não encontradas.', 16, 1) end
    RESTORE VERIFYONLY FROM  DISK = N'/var/opt/mssql/data/pgd_susep.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
END
GO
-- Fim

-- Início backup de outros bancos..
