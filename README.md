# SUSEP/PGD - Docker

**Versão atual:** 1.7 (com adaptações a partir do código da branch "docker" em https://github.com/spbgovbr/Sistema_Programa_de_Gestao_Susep/tree/docker)

#### Requisitos do ambiente para o build e deploy dos serviços

**Em Linux (Ubuntu/Debian):**
Docker  
Docker-compose v1 e/ou v2

**Em Windows:** 
WSL/2 (Ubuntu/Debian)  
Docker  
Docker-compose v1 e/ou v2

#### Execução da infraestrutura

1 - Acessar o diretório /pgd-supep, construir a imagem do pgd e push no registro
   `$> docker build -t user_registro/pdg-susep-ubuntu20:latest .`  
   `$> docker push user_registro/pdg-susep-ubuntu20:latest`  

2 - Acessar o diretório /sqlserver, construir a imagem do mssqlserver e push no registro
   `$> docker build -t user_registro/mssqlserverexpress-2019-ubuntu20:latest .`  
   `$> docker push user_registro/mssqlserverexpress-2019-ubuntu20:latest`

3 - Provisionar o container SQLServer
`$> docker-compose up -d`

4 - Provisionar o container do Proxy
`$> ... em breve.`

#### Contribuições
Sugestões de posíveis melhorias no Dockerfile são sempre bem vindas.
