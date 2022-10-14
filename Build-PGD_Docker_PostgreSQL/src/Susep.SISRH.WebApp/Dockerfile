# Sobre o Dockerfile Multi-stage
###########################################################
# 1. Evita a criação manual de imagens intermediárias.
# 2. Reduz a complexidade.
# 3. Copia seletivamente artefatos de um estágio para outro.
# 4. Minimiza o tamanho final da imagem.

# Créditos e Desenvolvimento
###########################################################
# O Sistema PGD (versão SUSEP) é um sistema utilizado para pactuação e monitoramento dos resultados do Programa de Gestão (teletrabalho).
# Sistema de Programa de Gestão (SISPG) - Instrução Normativa Nº 65, de 30 de julho de 2020.
# Secretaria de Avaliação e Gestão da Informação (SESEP)
# Sistema de Recursos Humanos (SISRH)
# Programa de Gestão e Desempenho (PGD)
# https://www.gov.br/servidor/pt-br/assuntos/programa-de-gestao

# Sugestão para Conteinerização
###########################################################
# Erivando Sena
# Divisão de Infraestrutura, Segurança da Informação e Redes (DISIR)
# Diretoria de Tecnologia da Informação (DTI)
# Universidade da Integração Internacional da Lusofonia Afro-Brasileira (UNILAB)
# https://unilab.edu.br

#Consulte https://aka.ms/containerfastmode para entender como o Visual Studio usa esse Dockerfile para criar suas imagens para uma depuração mais rápida.

# ==== Stage 1 ====
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base

LABEL vendor="SUSEP" maintainer="Erivando Sena<erivandoramos@unilab.edu.br>" description="Programa de Gestão e Desempenho (PGD), APP Versão Docker" version="1.x.x"

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