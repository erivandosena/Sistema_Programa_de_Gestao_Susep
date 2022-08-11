/opt/mssql/bin/sqlservr &
pid=$!

echo "⏳ Aguardando o Microsoft SQL Server ficar disponível"

# Espere para ter certeza de que o SQL Server ficou Up.
sleep 60s

# Nota: certifique-se de que sua senha corresponda ao que está no Dockerfile
exists=$(/opt/mssql-tools/bin/sqlcmd -l 30 -S localhost -h-1 -V1 -U sa -P $SA_PASSWORD -Q "SET NOCOUNT ON SELECT case when name is not null then 1 else 0 end as existe from master.sys.databases where name = 'pgd_susep'")
if [[ $exists -eq 1 ]];
then
    echo "⏳ Realizando backup do banco de dados existente"
    # Executa o script de backup do banco de dados.
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d pgd_susep -i backup-database.sql
else
    echo "⏳ Criando novo banco de dados Microsoft SQL Server"
    # Executa o script para criar o(s) banco(s) de dados.
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i create-database.sql

    sleep 20s
    echo "⏳ Aplicando migrações no banco de dados existente"
    # Executa o script de migrações do banco de Dados 
    /usr/src/sqlserver-init/config-database.sh

    sleep 10s
    echo "⏳ Realizando backup inicial do banco de dados"
    # Executa o script de backup do banco de dados.
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d pgd_susep -i backup-database.sql

    sleep 10s
    echo "⏳ Restaurando backup para novos bancos de dados Microsoft SQL Server"
    # Executa o script de restauração de backup do banco de dados.
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d pgd_susep -i restore-database.sql
fi

# Para que o contêiner não seja encerrado, durma esta thread.
wait $pid
exit 0
