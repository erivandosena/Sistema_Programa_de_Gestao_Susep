# SUSEP - Docker

**Versão atual:** 1.7 (com adaptações a partir do código da branch "docker" em https://github.com/spbgovbr/Sistema_Programa_de_Gestao_Susep/tree/docker)

#### Requisitos do ambiente para o build da imagem

**Em Linux (Ubuntu/Debian):** 
Docker  
Docker-compose (opcional neste momento)  

**Em Windows:**  
WSL/2 (Ubuntu/Debian) 
Docker  
Docker-compose (opcional neste momento) 

## Stacks Gestão e Desempenho (PGD) SUSEP
> Ambientes de **Treinamento**, **Staging** e **Produção** para o PGD

##### Compose dos ambientes PGD

`$> docker-compose -p proj-staging -f docker-compose.staging.yml up -d`
`$> docker-compose -p proj-train -f docker-compose.treinamento.yml up -d`
`$> docker-compose -p proj-prod -f docker-compose.producao.yml up -d`

#### Contribuições 
Sugestões de posíveis melhorias no Docker Compose são sempre bem vindas.