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
Sending build context to Docker daemon  52.48MB
Step 1/29 : FROM mcr.microsoft.com/dotnet/aspnet:3.1-focal AS base
 ---> cf271fd64b76
Step 2/29 : LABEL vendor="SUSEP" maintainer="Erivando Sena<erivandosena@gmail.com>" description="Programa de Gestão e Desempenho (PGD), Versão SUSEP Docker" version="1.7.x"
 ---> Using cache
 ---> 8a168e7079b9
Step 3/29 : RUN apt-get update  && apt-get upgrade -y  && apt-get autoremove -y  && apt-get install -y sudo  && addgroup --group sispg  && adduser --disabled-password --no-create-home --ingroup sispg --gecos '' susep  && chmod 755 /etc/sudoers.d  && usermod -aG sudo susep  && echo 'susep ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers.d/susep  && chmod 440 /etc/sudoers.d/susep  && mkdir /app  && chown -Rf susep:sispg /app
 ---> Using cache
 ---> 1583196580dd
Step 4/29 : EXPOSE 80
 ---> Using cache
 ---> fb1804642448
Step 5/29 : EXPOSE 443
 ---> Using cache
 ---> 89443153ce0a
Step 6/29 : FROM mcr.microsoft.com/dotnet/sdk:3.1-focal as build
 ---> cb7b5e5a1183
Step 7/29 : RUN apt-get update  && apt-get install -y nodejs npm --no-install-recommends
 ---> Using cache
 ---> 1d6f60253f0e
Step 8/29 : RUN echo "NODE Version:" && node --version
 ---> Using cache
 ---> 5c47ee31fa4d
Step 9/29 : RUN echo "NPM Version:" && npm --version
 ---> Using cache
 ---> b5fd54565cd9
Step 10/29 : COPY src /src
 ---> Using cache
 ---> 48b0e90c4013
Step 11/29 : WORKDIR /src
 ---> Using cache
 ---> 25be8a214ea5
Step 12/29 : COPY Nuget.config ~/.nuget/NuGet/Nuget.Config
 ---> Using cache
 ---> b51753c92e1a
Step 13/29 : RUN dotnet nuget enable source nuget.org
 ---> Using cache
 ---> 6726243fd59c
Step 14/29 : RUN dotnet nuget locals all --list
 ---> Using cache
 ---> 3820e8056717
Step 15/29 : RUN dotnet nuget locals all --clear
 ---> Using cache
 ---> 7c4f43ff97a5
Step 16/29 : RUN dotnet nuget update
 ---> Using cache
 ---> c032b1e0f11c
Step 17/29 : RUN dotnet add "Susep.SISRH.Domain/Susep.SISRH.Domain.csproj" package Newtonsoft.Json
 ---> Using cache
 ---> 8425fa0fcfa4
Step 18/29 : RUN dotnet dev-certs https --clean
 ---> Using cache
 ---> 6c90941b0285
Step 19/29 : RUN dotnet dev-certs https -v
 ---> Using cache
 ---> 561708ac4bc0
Step 20/29 : RUN dotnet restore Susep.SISRH.sln -- configfile ~/.nuget/NuGet/Nuget.Config
 ---> Using cache
 ---> 2d5db27ee8c1
Step 21/29 : RUN dotnet build --configuration Release
 ---> Using cache
 ---> 454799c6d00e
Step 22/29 : FROM build AS publication
 ---> 454799c6d00e
Step 23/29 : RUN dotnet publish --configuration Release
 ---> Using cache
 ---> ec8db44756e7
Step 24/29 : FROM base AS final
 ---> 89443153ce0a
Step 25/29 : WORKDIR /app
 ---> Using cache
 ---> eb84b6c5b029
Step 26/29 : USER susep
 ---> Using cache
 ---> 375c82befb42
Step 27/29 : COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.WebApi/bin/Release/netcoreapp3.1/publish /app/api/
 ---> Using cache
 ---> cd9f813ff594
Step 28/29 : COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.ApiGateway/bin/Release/netcoreapp3.1/publish /app/gateway/
 ---> Using cache
 ---> a2c418a54173
Step 29/29 : COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.WebApp/bin/Release/netcoreapp3.1/publish /app/app/
 ---> Using cache
 ---> a791ed550574
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
Sugestões de posíveis melhorias no Dockerfile são bem vindas.
