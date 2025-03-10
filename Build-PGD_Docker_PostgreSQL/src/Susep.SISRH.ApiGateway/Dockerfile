# Sobre o Dockerfile Multi-stage
###########################################################
# 1. Evita a cria��o manual de imagens intermedi�rias.
# 2. Reduz a complexidade.
# 3. Copia seletivamente artefatos de um est�gio para outro.
# 4. Minimiza o tamanho final da imagem.

# Cr�ditos e Desenvolvimento
###########################################################
# O Sistema PGD (vers�o SUSEP) � um sistema utilizado para pactua��o e monitoramento dos resultados do Programa de Gest�o (teletrabalho).
# Sistema de Programa de Gest�o (SISPG) - Instru��o Normativa N� 65, de 30 de julho de 2020.
# Secretaria de Avalia��o e Gest�o da Informa��o (SESEP)
# Sistema de Recursos Humanos (SISRH)
# Programa de Gest�o e Desempenho (PGD)
# https://www.gov.br/servidor/pt-br/assuntos/programa-de-gestao

# Sugest�o para Conteineriza��o
###########################################################
# Erivando Sena
# Divis�o de Infraestrutura, Seguran�a da Informa��o e Redes (DISIR)
# Diretoria de Tecnologia da Informa��o (DTI)
# Universidade da Integra��o Internacional da Lusofonia Afro-Brasileira (UNILAB)
# https://unilab.edu.br

#Consulte https://aka.ms/containerfastmode para entender como o Visual Studio usa esse Dockerfile para criar suas imagens para uma depura��o mais r�pida.

# ==== Stage 1 ====
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base

LABEL vendor="SUSEP" maintainer="Erivando Sena<erivandoramos@unilab.edu.br>" description="Programa de Gest�o e Desempenho (PGD), APP Vers�o Docker" version="1.x.x"

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get autoremove -y \
 && apt-get install -y iputils-ping nano -y

WORKDIR /app

EXPOSE 80
EXPOSE 443

# ==== Stage 2 ====
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get autoremove -y \
 && apt-get install -y nodejs npm --no-install-recommends 

RUN echo "NODE Version:" && node --version
RUN echo "NPM Version:" && npm --version

WORKDIR /src

COPY ["Susep.SISRH.WebApp/Susep.SISRH.WebApp.csproj", "Susep.SISRH.WebApp/"]

RUN dotnet restore "Susep.SISRH.WebApp/Susep.SISRH.WebApp.csproj"

COPY . .

WORKDIR "/src/Susep.SISRH.WebApp"

RUN dotnet build "Susep.SISRH.WebApp.csproj" -c Release -o /app/build

# ==== Stage 3 ====
FROM build AS publish

RUN dotnet publish "Susep.SISRH.WebApp.csproj" -c Release -o /app/publish

# ==== Stage 4 ====
FROM base AS final

WORKDIR /app

COPY --from=publish /app/publish .