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

#### Execução do Build da Imagem do SQL Server Express  

`$> docker build -f ./docker-mssqlserver/Dockerfile  -t erivando/mssqlserverexpress-2019-ubuntu20:latest .`  
`$> docker push SEU-USER/mssqlserverexpress-2019-ubuntu20:latest` (Opcional no momento)  

#### Execução do Build da Imagem do PGD para SQL Server Express  

`$> docker build -t erivando/pdg-susep-ubuntu20-mssqlserver:latest .`  
`$> docker push SEU-USER/pdg-susep-ubuntu20-mssqlserver:latest` (Opcional no momento)  

##### Compose para provisionamento do SQL Server Express  

`$> docker-compose up -d`  
