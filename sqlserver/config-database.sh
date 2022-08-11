## I. Criação da estrutura do banco de dados - Obrigatorio
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/1. Criação da estrutura do banco de dados - Obrigatorio.sql"

## II. Inserir dados de domínio - Obrigatorio
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/2. Inserir dados de domínio - Obrigatorio.sql"

## III. Criação da tabela pessoa alocacao temporaria - Obrigatorio
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/3. Criação da tabela pessoa alocacao temporaria - Obrigatorio.sql"

## IV. Alteracoes da estrutura do BD para a V7 - Correção de bugs
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/5. Alteracoes da estrutura do BD para a V7.sql"

## V. Inserir dados de teste - Opcional
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/4. Inserir dados de teste - Opcional.sql"

## 1. Update Script 1 - Sob Demanda
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/Script 1 - CREATE_TABLES_SQL_SERVER_SUSEP.sql"

## 2. Update Script 2 - Sob Demanda
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/Script 2 - VEWS_API_PGD_SUSEP - VERSOES_ANTERIORES_A_v7.sql"

## 3. Update Script 2 - Sob Demanda
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i "/usr/src/sqlserver-init/sqls/Script 2 - VIEWS_API_PGD_SUSEP.sql"

## Script extras - Sob Demanda
/opt/mssql-tools/bin/sqlcmd -S localhost -U admin -P $ADM_PASSWORD -d pgd_susep -i /usr/src/sqlserver-init/sqls/Script-comandos-sql-sobdemanda.sql