echo "⏳ Configurando o Microsoft SQL Server"

# Execute o Microsoft SQL Server e o script de inicialização (ao mesmo tempo).
/usr/src/sqlserver-init/run-initialization.sh & /opt/mssql/bin/sqlservr
