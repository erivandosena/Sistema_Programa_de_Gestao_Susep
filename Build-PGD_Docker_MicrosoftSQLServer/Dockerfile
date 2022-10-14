# Sobre o Dockerfile Multi-stage
###########################################################
# 1. Evita a criacao manual de imagens intermediarias.
# 2. Reduz a complexidade.
# 3. Copia seletivamente artefatos de um estagio para outro.
# 4. Minimiza o tamanho final da imagem.

# Instruções
###########################################################
# docker build -f ./Dockerfile -t erivando/pdg-susep-ubuntu20-mssqlserver:latest ./src/

# Creditos e Desenvolvimento
###########################################################
# O Sistema PGD (versao SUSEP) sistema utilizado para pactuacao e monitoramento dos resultados do Programa de Gestao (teletrabalho).
# Sistema de Programa de Gestao (SISPG) - Instrucao Normativa N. 65, de 30 de julho de 2020.
# Secretaria de Avaliacao e Gestao da Informacao (SESEP)
# Sistema de Recursos Humanos (SISRH)
# Programa de Gestao e Desempenho (PGD)
# https://www.gov.br/servidor/pt-br/assuntos/programa-de-gestao

# Sugestao para Conteinerizacao
###########################################################
# Erivando Sena
# Divisao de Infraestrutura, Seguranca da Informacao e Redes (DISIR)
# Diretoria de Tecnologia da Informacao (DTI)
# Universidade da Integracao Internacional da Lusofonia Afro-Brasileira (UNILAB)
# https://unilab.edu.br

# Consulte https://aka.ms/containerfastmode para entender como o Visual Studio usa esse Dockerfile para criar suas imagens para uma depuracao mais rapida.

# ==== Stage 1 ==== #
FROM mcr.microsoft.com/dotnet/aspnet:3.1-focal AS base

LABEL vendor="SUSEP" maintainer="Erivando Sena<erivandoramos@unilab.edu.br>" description="Programa de Gestão e Desempenho (PGD), Versão SUSEP Docker" version="1.7.x"

WORKDIR /app

# Atualiza lista de pacotes
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get autoremove -y \
 && apt-get install -y iputils-ping nano -y \
 && mkdir -p /opt/pgd \
 && ln -s /app /opt/pgd

EXPOSE 80
EXPOSE 443

# ==== Stage 2 ==== #
FROM mcr.microsoft.com/dotnet/sdk:3.1-focal as build

# Atualiza lista de pacotes
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get autoremove -y \
 && apt-get install aptitude -y \
 && aptitude install npm -y

# Habilitando o repositorio de pacotes NuGet
COPY Nuget.config ~/.nuget/NuGet/Nuget.Config
RUN dotnet nuget enable source nuget.org
RUN dotnet nuget locals all --list
RUN dotnet nuget locals all --clear

WORKDIR /src

## Adiciona/atualiza referência de pacotes no(s) projeto(s)
#RUN dotnet add "Susep.SISRH.Application/Susep.SISRH.Application.csproj" package Npgsql.EntityFrameworkCore.PostgreSQL --version 3.1.4
#RUN dotnet add "Susep.SISRH.Domain/Susep.SISRH.Domain.csproj" package Microsoft.AspNetCore.Mvc.NewtonsoftJson --version 3.1.5
#RUN dotnet add "Susep.SISRH.WebApi/Susep.SISRH.WebApi.csproj" package Serilog --version 2.9.0
#RUN dotnet add "Susep.SISRH.WebApi/Susep.SISRH.WebApi.csproj" package Serilog.AspNetCore --version 3.2.0
#RUN dotnet add "Susep.SISRH.WebApi/Susep.SISRH.WebApi.csproj" package Serilog.Sinks.File --version 4.1.0

# Import project WebApi
COPY ["Susep.SISRH.WebApi/Susep.SISRH.WebApi.csproj", "Susep.SISRH.WebApi/"]
COPY ["Susep.SISRH.Application/Susep.SISRH.Application.csproj", "Susep.SISRH.Application/"]
COPY ["Susep.SISRH.Infrastructure/Susep.SISRH.Infrastructure.csproj", "Susep.SISRH.Infrastructure/"]
COPY ["Susep.SISRH.Domain/Susep.SISRH.Domain.csproj", "Susep.SISRH.Domain/"]
# Import project ApiGateway
COPY ["Susep.SISRH.ApiGateway/Susep.SISRH.ApiGateway.csproj", "Susep.SISRH.ApiGateway/"]
# Import project WebApp
COPY ["Susep.SISRH.WebApp/Susep.SISRH.WebApp.csproj", "Susep.SISRH.WebApp/"]

# Restore WebApi
RUN dotnet restore "Susep.SISRH.WebApi/Susep.SISRH.WebApi.csproj" -- configfile ~/.nuget/NuGet/Nuget.Config
# Restore ApiGateway
RUN dotnet restore "Susep.SISRH.ApiGateway/Susep.SISRH.ApiGateway.csproj" -- configfile ~/.nuget/NuGet/Nuget.Config
# Restore WebApp
RUN dotnet restore "Susep.SISRH.WebApp/Susep.SISRH.WebApp.csproj" -- configfile ~/.nuget/NuGet/Nuget.Config

COPY . .

# Build WebApi
WORKDIR "/src/Susep.SISRH.WebApi"
RUN dotnet build "Susep.SISRH.WebApi.csproj" -c Release -o /app/api/build

# Build ApiGateway
WORKDIR "/src/Susep.SISRH.ApiGateway"
RUN dotnet build "Susep.SISRH.ApiGateway.csproj" -c Release -o /app/gateway/build

# Build WebApp
WORKDIR "/src/Susep.SISRH.WebApp"
RUN dotnet build "Susep.SISRH.WebApp.csproj" -c Release -o /app/app/build

# ==== Stage 3 ==== #
FROM build AS publication

# Publica WebApi
WORKDIR "/src/Susep.SISRH.WebApi"
RUN dotnet publish "Susep.SISRH.WebApi.csproj" -c Release -o /app/api/publish

# Publica ApiGateway
WORKDIR "/src/Susep.SISRH.ApiGateway"
RUN dotnet publish "Susep.SISRH.ApiGateway.csproj" -c Release -o /app/gateway/publish

# Publica WebApp
WORKDIR "/src/Susep.SISRH.WebApp"
RUN dotnet publish "Susep.SISRH.WebApp.csproj" -c Release -o /app/app/publish

# ==== Stage 4 ==== #
FROM base AS final

WORKDIR /opt/pgd

COPY --from=publication /app/api/publish ./api/
COPY --from=publication /app/gateway/publish ./gateway/
COPY --from=publication /app/app/publish ./app/
