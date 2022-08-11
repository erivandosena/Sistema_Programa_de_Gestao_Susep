# SUSEP/PGD - Docker

**Versão atual:** 1.7 (com adaptações a partir do código da branch "docker" em https://github.com/spbgovbr/Sistema_Programa_de_Gestao_Susep/tree/docker)

#### Requisitos do ambiente para o build da imagem

**Em Linux (Ubuntu/Debian):**
Docker  
Docker-compose v1 e/ou v2

**Em Windows:** 
WSL/2 (Ubuntu/Debian)  
Docker  
Docker-compose v1 e/ou v2

#### Execução SQL Server Express

`$> docker build -t user_registro/mssqlserverexpress-2019-ubuntu20:latest .`  
`$> docker push user_registro/mssqlserverexpress-2019-ubuntu20:latest`
`$> docker-compose up -d`

#### Saídas no console do terminal
```console
erivando@wsl-ubuntu:/home/sqlserver$ docker build -t erivando/mssqlserverexpress-2019-ubuntu20:latest .
Sending build context to Docker daemon  131.4MB
Step 1/29 : FROM mcr.microsoft.com/mssql/server:2019-CU16-GDR1-ubuntu-20.04
 ---> 9ab26f8e5685
Step 2/29 : LABEL vendor="Microsoft" maintainer="Erivando Sena<erivandosena@gmail.com>" description="Sistema Operacional Ubuntu com Microsoft SQL Server Express 2019" version="1.0.0"
 ---> Using cache
 ---> c8f5ba3663e6
Step 3/29 : USER root
 ---> Using cache
 ---> 7024618b4724
Step 4/29 : ARG script_sql_obrigatorio_a="install/1. Criação da estrutura do banco de dados - Obrigatorio.sql"
 ---> Using cache
 ---> 781ae9c5ae19
Step 5/29 : ARG script_sql_obrigatorio_b="install/2. Inserir dados de domínio - Obrigatorio.sql"
 ---> Using cache
 ---> d4221b5ecd99
Step 6/29 : ARG script_sql_obrigatorio_c="install/3. Criação da tabela pessoa alocacao temporaria - Obrigatorio.sql"
 ---> Using cache
 ---> 15db4118f95e
Step 7/29 : ARG script_sql_obrigatorio_d="install/4. Inserir dados de teste - Opcional.sql"
 ---> Using cache
 ---> 42e3bc2b422e
Step 8/29 : ARG script_sql_opcional_e="install/5. Alteracoes da estrutura do BD para a V7.sql"
 ---> Using cache
 ---> 1c972d05c18a
Step 9/29 : ARG script_sql_opcional_1="sql-codes/Script 1 - CREATE_TABLES_SQL_SERVER_SUSEP.sql"
 ---> Using cache
 ---> 00a00a436737
Step 10/29 : ARG script_sql_opcional_2="sql-codes/Script 2 - VIEWS_API_PGD_SUSEP.sql"
 ---> Using cache
 ---> d14204b354d1
Step 11/29 : RUN mkdir -p /usr/src/sqlserver-init/sqls
 ---> Using cache
 ---> 1e661b604fa2
Step 12/29 : WORKDIR /usr/src/sqlserver-init
 ---> Using cache
 ---> a788a08466b5
Step 13/29 : COPY *.sh ./
 ---> c254c446517d
Step 14/29 : RUN chmod +x ./*.sh
 ---> Running in 0c1dba8d01d0
Removing intermediate container 0c1dba8d01d0
 ---> f73831bd851a
Step 15/29 : COPY sql-codes/ ./
 ---> 4cf28cfb439d
Step 16/29 : RUN mv Script-comandos-sql-sobdemanda.sql /usr/src/sqlserver-init/sqls/
 ---> Running in 5239b538df4d
Removing intermediate container 5239b538df4d
 ---> 40495fe89d97
Step 17/29 : COPY ${script_sql_obrigatorio_a} /usr/src/sqlserver-init/sqls/
 ---> 934b155f5a1d
Step 18/29 : COPY ${script_sql_obrigatorio_b} /usr/src/sqlserver-init/sqls/
 ---> b209f18f58f8
Step 19/29 : COPY ${script_sql_obrigatorio_c} /usr/src/sqlserver-init/sqls/
 ---> 213bc0863947
Step 20/29 : COPY ${script_sql_obrigatorio_d} /usr/src/sqlserver-init/sqls/
 ---> 6d516fee120a
Step 21/29 : COPY ${script_sql_opcional_e} /usr/src/sqlserver-init/sqls/
 ---> 2b1697ba061a
Step 22/29 : COPY ${script_sql_opcional_1} /usr/src/sqlserver-init/sqls/
 ---> e7ee9a8f76bf
Step 23/29 : COPY ${script_sql_opcional_2} /usr/src/sqlserver-init/sqls/
 ---> 9e364cf65eb7
Step 24/29 : ENV SA_PASSWORD Sql@server2019
 ---> Running in 6af2908e5a8f
Removing intermediate container 6af2908e5a8f
 ---> 9fd476955988
Step 25/29 : ENV ADM_PASSWORD Sql@server2019Express
 ---> Running in 5b4b3c5cac07
Removing intermediate container 5b4b3c5cac07
 ---> d852c326e341
Step 26/29 : ENV ACCEPT_EULA Y
 ---> Running in 1257cfb91804
Removing intermediate container 1257cfb91804
 ---> 1fe868cdb81a
Step 27/29 : ENV MSSQL_PID Express
 ---> Running in bc32305cb79f
Removing intermediate container bc32305cb79f
 ---> 6619db6c42a7
Step 28/29 : EXPOSE 1433
 ---> Running in 3e9362ca813c
Removing intermediate container 3e9362ca813c
 ---> c1aa2ca8728d
Step 29/29 : CMD /bin/bash ./entrypoint.sh
 ---> Running in 20f362545d70
Removing intermediate container 20f362545d70
 ---> 4d7879cc832a
Successfully built 4d7879cc832a
Successfully tagged erivando/pdg-susep-ubuntu20:latest
```

#### Contribuições
Sugestões de posíveis melhorias no Dockerfile e Docker Compose são sempre bem vindas.
