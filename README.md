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

#### Implementação da infraestrutura

![Gitlab DTI](https://doc.traefik.io/traefik/assets/img/traefik-concepts-1.png)
Traefik com configuração de roteamento dinâmico e configuração de inicialização estática. *Fonte imagem, doc.traefik.io*

Antes de iniciar, leia as observações.

1 - Acessar o diretório **/proxy**, provisionar o container do Proxy com
`$> docker-compose up -d` e logs com
`$> cat logs/traefik/traefik.log`

2 - Acessar o diretório **/pgd-supep**, construir a imagem do pgd e push no registro para pulling da imagem futuramente.
`$> docker build -t user_registro/pdg-susep-ubuntu20:latest .`  
`$> docker push user_registro/pdg-susep-ubuntu20:latest`  

2 - Acessar o diretório **/sqlserver**, construir a imagem do mssqlserver e push no registro para pulling da imagem futuramente.
`$> docker build -t user_registro/mssqlserverexpress-2019-ubuntu20:latest .`  
`$> docker push user_registro/mssqlserverexpress-2019-ubuntu20:latest`

3 - Provisionar o container SQLServer. 
`$> docker-compose up -d`

4 - Acessar o diretório **/stacks**, e provisionar o(s) container(s) PGD conforme necessidade.
- *Para testes da equipe de TI e homologações com gestores*
`$> docker compose -p proj-staging -f docker-compose.staging.yml up -d`  

- *Para treinamentos dos usários*
`$> docker compose -p proj-train -f docker-compose.treinamento.yml up -d`  

- *Para produção*
`$> docker compose -p proj-prod -f docker-compose.producao.yml up -d` 

5 - Após alguns minutos aplicação estará disponível  no host conforme protocolo/domain.
Ex.: *http://pgd.localhost.staging/*
Ex.: *http://pgd.localhost.treinamento/*
Ex.: *http://pgd.localhost/*

6 - Teste inicial.
*Usuário: sisgp_gestor*
*Senha: qualquer caractere*

7 - Dashboard Traefik
Ex.: *http://traefik.localhost.dashboard:8080/*

### Nota
Os dados informados na implementação relacionados a nomes de domínios, certificados, usuário, senhas, etc. São meramente didáticos e tais informações sensíveis devem ser adaptadas a sua realidade de ambiente e infraestrutura.

Não fez parte do escopo desta configuração ferramenta de orquestração para automatização da implantação,  gerenciamento, escala e rede dos containers.

##### Observações
Para uma experiência completa do ambiente apresentado, faz necessário alguns ajustes em sua máquina local antes de iniciar os containers:

- No Windows editar o arquivo hosts em **`C:\Windows\System32\drivers\etc\hosts`**
- No Linux editar o arquivo hosts em **`/etc/hosts`** incluir as linhas abaixo:
```console
# PGD locais
127.0.0.1       pgd.localhost
127.0.0.1       pgd.localhost.staging
127.0.0.1       pgd.localhost.treinamento
127.0.0.1       traefik.localhost.dashboard
```
- Se preferir, no WSL/2 (Subsistema Windows para Linux)
- `sudo ln -s /mnt/c/Windows/System32/drivers/etc/hosts /etc/hosts` e edite o arquivo hosts pelo Windows

> Configuração opcional

Ativar  Port Forwarding (WSL2) no PowerShell:

*Visualizar entradas existentes*
```console
netsh interface portproxy show v4tov4
```
*Adicionar entrada*
```console
                                                                (Ethernet windows)                        (eth0 linux wsl)
netsh interface portproxy set v4tov4 listenport=80 listenaddress=192.168.x.x connectport=80 connectaddress=172.x.x.x
```
*Remover entrada*
```console
netsh interface portproxy delete v4tov4 listenport=80 listenaddress=192.168.x.x
```
*Limpar tudo*
```console
netsh interface portproxy reset v4tov4
```
O acesso aos bancos de dados é padrão através do **Microsoft SQL Server Management Studio**, com **Autenticação do SQL Server**, usuário `admin` senha `Sql@server2019Express` e o servidor, endereço do host onde está subindo os serviços, se usar WSL é o endereço `eth0` obtido com o comando `ip route`.

#### Contribuições
Sugestões de possíveis melhorias no Dockerfile, Docker Compose e Traefik são bem vindas.
