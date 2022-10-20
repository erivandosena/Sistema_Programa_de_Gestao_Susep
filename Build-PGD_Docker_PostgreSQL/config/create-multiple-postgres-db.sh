#!/bin/bash

set -e
set -u

# Espere para ter certeza de que o PostgreSQL ficou Up.
echo "⏳ Aguardando o SGBD ficar disponível"
sleep 45s

echo " ⏳ Configurando o PostgreSQL"

# Connection options:
#   -h, --host=HOSTNAME      host do servidor de banco de dados
#   -p, --port=PORT          porta do servidor de banco de dados
#   -U, --username=USERNAME  nome de usuário do banco de dados
#   -w, --no-password        nunca solicitar senha
#   -W, --password           forçar prompt de senha (should happen automatically)

# databases
function create_user_and_database() {
	local database=$1
	echo " ⏳ Elevando o usuario e criando o banco de dados $database"
	psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=postgres user=$POSTGRESQL_SUPERADMIN_USERNAME" -W "$POSTGRESQL_SUPERADMIN_PASSWORD" <<-EOSQL
	    
        ------------------------------------------------------------------------------------
        -- CONFIGURA USUARIO E SENHA
        ------------------------------------------------------------------------------------
        ALTER USER "$POSTGRESQL_USERNAME" WITH 
            SUPERUSER
            LOGIN 
            CREATEDB
            CREATEROLE
            REPLICATION
            INHERIT
            CONNECTION LIMIT -1;
        COMMENT ON ROLE pgd IS 'Usuario padrao do banco de dados';

        ------------------------------------------------------------------------------------
        -- CRIA DATABASE
        ------------------------------------------------------------------------------------
        CREATE DATABASE "$database"
            WITH
            OWNER = "$POSTGRESQL_USERNAME"
            ENCODING = 'UTF8'
            CONNECTION LIMIT = -1
            TEMPLATE template0;
        COMMENT ON DATABASE "$database" IS 'Dadabase PosgresSQL migrado do MS SqlServer.';

EOSQL
}

# schemas
function create_schemas() {
	local database=$1
	echo " ⏳ Configurando schemas para o banco de dados $database"
    psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" <<-EOSQL
        
        ------------------------------------------------------------------------------------
        -- CONFIGURA SCHEMAS para DATABASE E USUARIO PADRAO DO BANCO
        ------------------------------------------------------------------------------------
            
        CREATE SCHEMA IF NOT EXISTS dbo;
        CREATE SCHEMA IF NOT EXISTS "ProgramaGestao";
        GRANT ALL ON SCHEMA "ProgramaGestao" TO "$POSTGRESQL_USERNAME";
        GRANT ALL ON SCHEMA dbo TO "$POSTGRESQL_USERNAME";
        GRANT ALL PRIVILEGES ON DATABASE "$database" TO "$POSTGRESQL_USERNAME";
        SET search_path TO dbo;
        ALTER DATABASE "$database" SET search_path TO dbo;

        ------------------------------------------------------------------------------------
        -- EXCLUI O SCHEMA PADRAO
        ------------------------------------------------------------------------------------
        DROP SCHEMA IF EXISTS public CASCADE;

EOSQL
}
function config_user() {
	local database=$1
	echo " ⏳ Configurando usuário do banco de dados $database"
	psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=postgres user=$POSTGRESQL_SUPERADMIN_USERNAME" -W "$POSTGRESQL_SUPERADMIN_PASSWORD" <<-EOSQL
	    
        ------------------------------------------------------------------------------------
        -- CONFIGURA USUARIO
        ------------------------------------------------------------------------------------
        ALTER USER "$POSTGRESQL_USERNAME" WITH 
            --SUPERUSER
            LOGIN 
            CREATEDB
            CREATEROLE
            REPLICATION
            INHERIT
            CONNECTION LIMIT -1;
EOSQL
}

# migrations
function create_migrations() {
	local database=$1

    echo " ⏳ Criando tabelas no $database"

    #################################################################################################
    #  Scripts necessários para criação da estrutura inicial do database.                           #
    #################################################################################################
    ## I. Criação da estrutura do banco de dados - Obrigatorio
    psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/install/1. Criação da estrutura do banco de dados - Obrigatorio.sql"

    ## II. Inserir dados de domínio - Obrigatorio
    psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/install/2. Inserir dados de domínio - Obrigatorio.sql"

    ## III. Criação da tabela pessoa alocacao temporaria - Obrigatorio
    psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/install/3. Criação da tabela pessoa alocacao temporaria - Obrigatorio.sql"

    ## IV. Alteracoes da estrutura do BD para a V7 - Correção de bugs
    psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/install/4. Alteracoes da estrutura do BD para a V7.sql"

    ## V. Inserir dados de teste - Opcional ) (não necessário para produção)
    psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/install/5. Inserir dados de teste - Opcional.sql"

    ## VI. Funcoes PostgreSQL - Obrigatorio
    psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/install/6. Funcoes PostgreSQL - Obrigatorio.sql"

    #################################################################################################
    #  Scripts necessários para a instalação da API de envio dos dados de PGD para o órgão central. #
    #################################################################################################
    ## 1. Update Script 1 - Sob Demanda
    #psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/Script 1 - CREATE_TABLES_SQL_SERVER_SUSEP.sql"

    ## 2. Update Script 2 - Sob Demanda (versoes anteriores v1.7)
    ## psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/Script 2 - VEWS_API_PGD_SUSEP - VERSOES_ANTERIORES_A_v7.sql"

    ## 3. Update Script 2 - Sob Demanda (versoes v1.7+)
    #psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f "/docker-entrypoint-initdb.d/sqls/Script 2 - VIEWS_API_PGD_SUSEP.sql"

    ## Script extras - Sob Demanda (para listar pessoas versoes update v1.7+)
    psql -v ON_ERROR_STOP=1 -d "host=localhost port=5432 dbname=$database user=$POSTGRESQL_USERNAME" -W "$POSTGRESQL_PASSWORD" -a -q -f /docker-entrypoint-initdb.d/sqls/Script-comandos-sql-sobdemanda.sql
}

if [ "$( psql -XtAc "SELECT 1 FROM pg_database WHERE datname='pgd_staging'" )" = '1' ]
then
    echo " ⏳ Banco de dados existente."
else
    if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
        for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
            create_user_and_database $db
        done
    fi

    if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
        for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
            create_schemas $db
        done
    fi

    if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
        for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
            create_migrations $db
        done
    fi

    if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
        for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
            config_user $db
        done
    fi
fi
