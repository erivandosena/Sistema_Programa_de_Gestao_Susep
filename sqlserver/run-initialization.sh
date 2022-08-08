/opt/mssql/bin/sqlservr &
pid=$!

echo "⏳ Aguardando o Microsoft SQL Server ficar disponível"

# Espere para ter certeza de que o SQL Server ficou Up.
sleep 60s

# Nota: certifique-se de que sua senha corresponda ao que está no Dockerfile
exists=$(/opt/mssql-tools/bin/sqlcmd -l 30 -S localhost -h-1 -V1 -U sa -P $SA_PASSWORD -Q "SET NOCOUNT ON SELECT case when name is not null then 1 else 0 end as existe from master.sys.databases where name = 'pgd_susep'")
if [[ $exists -eq 1 ]];
then
    echo "⏳ Aplicando migrações no banco de dados existente do Microsoft SQL Server"
    # Execute o script de configuração para configurar o banco de dados e o esquema.
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d pgd_susep -i change-database.sql
else
    echo "⏳ Criando novo banco de dados Microsoft SQL Server"
    # Execute o script de configuração para criar o banco de dados e o esquema no banco de dados.
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i create-database.sql

    sleep 10s

    ## I. Criação da estrutura do banco de dados - Obrigatorio
    /opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/1. Criação da estrutura do banco de dados - Obrigatorio.sql"
    
    ## II. Inserir dados de domínio - Obrigatorio
    /opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/2. Inserir dados de domínio - Obrigatorio.sql"
    
    ## III. Criação da tabela pessoa alocacao temporaria - Obrigatorio
    /opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/3. Criação da tabela pessoa alocacao temporaria - Obrigatorio.sql"
    
    ## IV. Inserir dados de teste - Opcional
    /opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/4. Inserir dados de teste - Opcional.sql"
    
    ## V. Alteracoes da estrutura do BD para a V7 - Correção de bugs
    /opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/5. Alteracoes da estrutura do BD para a V7.sql"
    
    ## 1. Update Script 1 - Sob Demanda
    /opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/Script 1 - CREATE_TABLES_SQL_SERVER_SUSEP.sql"
    
    ## 2. Update Script 2 - Sob Demanda
    /opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/Script 2 - VIEWS_API_PGD_SUSEP.sql"

    ## Script extras - Sob Demanda
    /opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i /usr/src/sqlserver-init/sqls/Script-comandos-sql-sobdemanda.sql
fi

# Para que o contêiner não seja encerrado, durma esta thread.
wait $pid
exit 0
