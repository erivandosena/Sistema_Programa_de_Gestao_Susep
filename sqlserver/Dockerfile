# Obtido de https://hub.docker.com/_/microsoft-mssql-server
#
# Build da imagem
# docker build -t erivando/mssqlserverexpress-2019-ubuntu20:latest .
#
# Up do container
# docker run --name sqlserver2019 --restart=always -p 1433:1433 -d erivando/mssqlserverexpress-2019-ubuntu20:latest
# 
# Obter logs
# docker logs --details -f sqlserver2019
#
# Obter Ip do servidor
# docker inspect sqlserver2019 | grep -i "IPaDDreSS"

FROM mcr.microsoft.com/mssql/server:2019-CU16-GDR1-ubuntu-20.04

# Definir informações para a imagem
LABEL vendor="Microsoft" maintainer="Erivando Sena<erivandosena@gmail.com>" description="Sistema Operacional Ubuntu com Microsoft SQL Server Express 2019" version="1.0.0"

# Eleva o root
USER root

# Cria diretório de aplicativos
RUN mkdir -p /usr/src/sqlserver-init/sqls

WORKDIR /usr/src/sqlserver-init

# Copiar scripts de inicialização
COPY *.sh ./

# Concede permissões para que o script de inicialização seja executável
RUN chmod +x ./*.sh

COPY sql-codes/ ./sqls/

RUN mv -fv ./sqls/create-database.sql ./
RUN mv -fv ./sqls/backup-database.sql ./
RUN mv -fv ./sqls/restore-database.sql ./

COPY install/*.sql /usr/src/sqlserver-init/sqls/

# Definir variáveis ​​de ambiente, para não ter que escrevê-las com o comando docker run
# Nota: certifique-se de que sua senha corresponda ao que está no script de inicialização de execução
ENV SA_PASSWORD Sql@server2019
ENV ADM_PASSWORD Sql@server2019Express
ENV ACCEPT_EULA Y
ENV MSSQL_PID Express

# Expor a porta padrao 1433 e alternativa em caso de acesso de outro container
EXPOSE 1433

# Executar o Microsoft SQL Server e o script de inicialização (ao mesmo tempo)
# Nota: Se deseja iniciar apenas o MsSQL (sem script de inicialização), pode comentar abaixo da linha, a entrada CMD da imagem base será tomada
CMD /bin/bash ./entrypoint.sh
