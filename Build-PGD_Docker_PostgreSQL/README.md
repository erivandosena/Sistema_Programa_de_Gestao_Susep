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

#### Execução do Build da Imagem do PostgreSQL

```
`$> docker build -t erivando/pdg-susep-ubuntu20-postgres:latest .`  
`$> docker push SEU-USER/pdg-susep-ubuntu20-postgres:latest` (Opcional no momento) 
```

#### Compose para provisionamento do PostgreSQL e pgAdmin 4
```
`$> docker-compose up -d`
```

#### Logs
```
`$> docker-compose logs -f`
```

#### Contribuições
Sugestões de posíveis melhorias no Dockerfile são bem vindas.
