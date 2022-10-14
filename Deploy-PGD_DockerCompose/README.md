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

##### Compose dos ambientes PGD 

`$> docker compose -p pgd-docker-sqlserver -f docker-compose.mssqlserver.yml up -d`  
`$> docker compose -p pgd-docker-postgres -f docker-compose.postgres.yml up -d`
