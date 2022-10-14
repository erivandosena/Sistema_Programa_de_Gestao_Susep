# SUSEP/PGD - Docker

**Versão atual:** 1.7 (com adaptações a partir do código da branch "docker" em https://github.com/spbgovbr/Sistema_Programa_de_Gestao_Susep/tree/docker)

#### Requisitos do ambiente para o build da imagem

**Em Linux (Ubuntu/Debian):** 
Docker  
Kubernetes (K8S)
HAProxy Kubernetes Ingress Controller 

**Em Windows:**  
WSL/2 (Ubuntu/Debian)  
Docker  
Kubernetes (Minikube ou K3s)
HAProxy Kubernetes Ingress Controller  

##### Deployments YAML para provisionamento do PGD em PostgreSQL e/ou SQL Server Express no Kubernetes

`$> kubectl apply -f pgd-postgres-deployment.yml`  
`$> kubectl apply -f postgres-deployment.yml` 
`$> kubectl apply -f pgadmin-deployment.yml` (Opcional conforme necessidade)  

### Observação:  
A construção do cluster Kubernetes e configuração do HAProxy Kubernetes Ingress Controller estão fora do escopo deste ambiente de instrução.  

#### Contribuições  
Sugestões de posíveis melhorias no Docker Compose e configurações estática/dinâmica nos YAMLs são bem vindas.
