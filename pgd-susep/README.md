# SUSEP/PGD - Docker

**Versão atual:** 1.7 (com adaptações a partir do código da branch "docker" em https://github.com/spbgovbr/Sistema_Programa_de_Gestao_Susep/tree/docker)

#### Requisitos do ambiente para o build da imagem

**Em Linux (Ubuntu/Debian):**
Docker  

**Em Windows:** 
WSL/2 (Ubuntu/Debian)  
Docker  

#### Execução do Build da Imagem

`$> docker build -t user_registro/pdg-susep-ubuntu20:latest .`  
`$> docker push user_registro/pdg-susep-ubuntu20:latest`

#### Saídas no console do terminal
```console
erivando@wsl-ubuntu:/home/pgd-susep$ docker build -t erivando/pdg-susep-ubuntu20:latest .
Sending build context to Docker daemon  82.53MB
Step 1/34 : FROM mcr.microsoft.com/dotnet/aspnet:3.1-focal AS base
 ---> 436ca6cb7cae
Step 2/34 : LABEL vendor="SUSEP" maintainer="Erivando Sena<erivandoramos@unilab.edu.br>" description="Programa de Gestão e Desempenho (PGD), Versão SUSEP Docker" version="1.7.x"
 ---> Using cache
 ---> cdaf519ae6d6
Step 3/34 : RUN apt-get update  && apt-get upgrade -y  && apt-get autoremove -y  && apt-get install -y sudo  && addgroup --group sispg  && adduser --disabled-password --no-create-home --ingroup sispg --gecos '' susep  && chmod 755 /etc/sudoers.d  && usermod -aG sudo susep  && echo 'susep ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers.d/susep  && chmod 440 /etc/sudoers.d/susep  && mkdir /app  && chown -Rf susep:sispg /app
 ---> Using cache
 ---> f7357cc60347
Step 4/34 : EXPOSE 80
 ---> Using cache
 ---> 1c81ccbb22c2
Step 5/34 : EXPOSE 443
 ---> Using cache
 ---> f61c3fe0af97
Step 6/34 : FROM mcr.microsoft.com/dotnet/sdk:3.1-focal as build
 ---> a9b8331e7365
Step 7/34 : RUN apt-get update  && apt-get install -y nodejs npm --no-install-recommends
 ---> Using cache
 ---> 55fb741b755e
Step 8/34 : RUN echo "NODE Version:" && node --version
 ---> Using cache
 ---> 2ea186934da0
Step 9/34 : RUN echo "NPM Version:" && npm --version
 ---> Using cache
 ---> 70ef3fe2ea32
Step 10/34 : RUN mkdir /NuGetPackages
 ---> Using cache
 ---> 807b689f88c2
Step 11/34 : COPY src /src
 ---> Using cache
 ---> 120af46e5f7c
Step 12/34 : WORKDIR /src
 ---> Using cache
 ---> c71eeb8f78db
Step 13/34 : COPY Nuget.config ~/.nuget/NuGet/Nuget.Config
 ---> Using cache
 ---> 6f59b1868bf5
Step 14/34 : RUN dotnet nuget enable source nuget.org
 ---> Using cache
 ---> d47329c6f20c
Step 15/34 : RUN dotnet nuget sources Add -Name "offlinePackages" -Source /NuGetPackages
 ---> Using cache
 ---> 62ec074b0dfc
Step 16/34 : RUN dotnet nuget locals all --list
 ---> Using cache
 ---> fe08734ccd0f
Step 17/34 : RUN dotnet nuget locals all --clear
 ---> Using cache
 ---> 818676ea5b79
Step 18/34 : RUN dotnet nuget update
 ---> Using cache
 ---> 7bb1d9368576
Step 19/34 : RUN dotnet add "Susep.SISRH.WebApi/Susep.SISRH.WebApi.csproj" package Microsoft.AspNetCore --version 2.2.0
 ---> Using cache
 ---> 8db8ae2b4fa6
Step 20/34 : RUN dotnet add "Susep.SISRH.WebApi/Susep.SISRH.WebApi.csproj" package Microsoft.AspNetCore --version 2.2.0
 ---> Using cache
 ---> 2b07a1040fee
Step 21/34 : RUN dotnet add "Susep.SISRH.ApiGateway/Susep.SISRH.ApiGateway.csproj" package Microsoft.AspNetCore --version 2.2.0
 ---> Using cache
 ---> cb4ce3b6e51c
Step 22/34 : RUN dotnet add "Susep.SISRH.Domain/Susep.SISRH.Domain.csproj" package Newtonsoft.Json
 ---> Using cache
 ---> 0da443f43a43
Step 23/34 : RUN dotnet dev-certs https --clean
 ---> Using cache
 ---> 5fc9977c80be
Step 24/34 : RUN dotnet dev-certs https -v
 ---> Using cache
 ---> 918f4b74556c
Step 25/34 : RUN dotnet restore Susep.SISRH.sln -- configfile ~/.nuget/NuGet/Nuget.Config
 ---> Using cache
 ---> d3a29f1fa5ba
Step 26/34 : RUN dotnet build --configuration Release
 ---> Using cache
 ---> 0df1b676290a
Step 27/34 : FROM build AS publication
 ---> 0df1b676290a
Step 28/34 : RUN dotnet publish --configuration Release --no-restore
 ---> Using cache
 ---> 59668ce5ed98
Step 29/34 : FROM base AS final
 ---> f61c3fe0af97
Step 30/34 : WORKDIR /app
 ---> Using cache
 ---> 7a393c7c86a3
Step 31/34 : USER susep
 ---> Using cache
 ---> 175938f46482
Step 32/34 : COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.WebApi/bin/Release/netcoreapp3.1/publish /app/api/
 ---> Using cache
 ---> f1481741f9ad
Step 33/34 : COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.ApiGateway/bin/Release/netcoreapp3.1/publish /app/gateway/
 ---> Using cache
 ---> 38bc7c5fc67d
Step 34/34 : COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.WebApp/bin/Release/netcoreapp3.1/publish /app/app/
 ---> Using cache
 ---> c7422c2fde8a
Successfully built c7422c2fde8a
Successfully tagged erivando/pdg-susep-ubuntu20:latest
```

```console
erivando@wsl-ubuntu:/home/pgd-susep$ docker push erivando/pdg-susep-ubuntu20:latest
The push refers to repository [docker.io/erivando/pdg-susep-ubuntu20]
5078007a2d3d: Layer already exists
d8952a868adc: Layer already exists
9d9a243df743: Layer already exists
b0969f6a15ec: Layer already exists
fa7cbc9c98d6: Layer already exists
4c3f9292a80d: Layer already exists
f4383345adad: Layer already exists
1a987155297d: Layer already exists
af7ed92504ae: Layer already exists
latest: digest: sha256:155acacf5e5c25c4adf8cb21196916614f5d77c7bce2d1f6db0c0ab99e2c25b1 size: 2218
```

#### Nota
Em caso de algum problema com o processo de build. A imagem latest do build apresentado estará disponível temporariamente no DockerHub em: 
https://hub.docker.com/r/erivando/pdg-susep-ubuntu20/tags

```
https://hub.docker.com/layers/pdg-susep-ubuntu20/erivando/pdg-susep-ubuntu20/latest/images/sha256-b8b6568a553b3b622ba31fed97524e1bbfc3807f01a3b1eca2a1f1c4ea35551e?context=explore
```

#### Contribuições
Sugestões de posíveis melhorias no Dockerfile são sempre bem vindas.
