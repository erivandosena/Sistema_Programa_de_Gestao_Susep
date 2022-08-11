
# Sobre o Dockerfile Multi-stage
###########################################################
# 1. Evita a criação manual de imagens intermediárias.
# 2. Reduz a complexidade.
# 3. Copia seletivamente artefatos de um estágio para outro.
# 4. Minimiza o tamanho final da imagem.

# Instruções
###########################################################
# docker build -t erivando/pdg-susep-ubuntu20:latest .

# Créditos e Desenvolvimento
###########################################################
# O Sistema PGD (versão SUSEP) é um sistema utilizado para pactuação e monitoramento dos resultados do Programa de Gestão (teletrabalho).
# Sistema de Programa de Gestão (SISPG) - Instrução Normativa Nº 65, de 30 de julho de 2020.
# Secretaria de Avaliação e Gestão da Informação (SESEP)
# Sistema de Recursos Humanos (SISRH)
# Programa de Gestão e Desempenho (PGD)
# https://www.gov.br/servidor/pt-br/assuntos/programa-de-gestao

# Sugestão para Conteinerização com (Docker/Docker-compose)
###########################################################
# Erivando Sena
# Divisão de Infraestrutura, Segurança da Informação e Redes (DISIR)
# Diretoria de Tecnologia da Informação (DTI)
# Universidade da Integração Internacional da Lusofonia Afro-Brasileira (UNILAB)
# https://unilab.edu.br

# ################################################################
#                        1ª ETAPA                                #
# ================================================================
# Definir a imagem base que será usada para produção.            #
# ================================================================
FROM mcr.microsoft.com/dotnet/aspnet:3.1-focal AS base

LABEL vendor="SUSEP" maintainer="Erivando Sena<erivandoramos@unilab.edu.br>" description="Programa de Gestão e Desempenho (PGD), Versão SUSEP Docker" version="1.7.x"

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get autoremove -y \
 && apt-get install -y sudo \
 && addgroup --group sispg \
 && adduser --disabled-password --no-create-home --ingroup sispg --gecos '' susep \
 && chmod 755 /etc/sudoers.d \
 && usermod -aG sudo susep \
 && echo 'susep ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers.d/susep \
 && chmod 440 /etc/sudoers.d/susep \
 && mkdir /app \
 && chown -Rf susep:sispg /app

EXPOSE 80
EXPOSE 443

# ################################################################
#                        2ª ETAPA                                #
# ================================================================
# Definir a imagem de SDK para construção da publicação.         #
# ================================================================
FROM mcr.microsoft.com/dotnet/sdk:3.1-focal as build

RUN apt-get update \
 && apt-get install -y nodejs npm --no-install-recommends 

RUN echo "NODE Version:" && node --version
RUN echo "NPM Version:" && npm --version

COPY src /src

WORKDIR /src

# Habilitando o gerenciamento de pacotes NuGet
COPY Nuget.config ~/.nuget/NuGet/Nuget.Config
RUN dotnet nuget enable source nuget.org
RUN dotnet nuget locals all --list
RUN dotnet nuget locals all --clear
RUN dotnet nuget update

# Adicionando referência de pacotes ausentes no projeto
RUN dotnet add "Susep.SISRH.Domain/Susep.SISRH.Domain.csproj" package Newtonsoft.Json

# Verifica certificados 
RUN dotnet dev-certs https --clean 
RUN dotnet dev-certs https -v

RUN dotnet restore Susep.SISRH.sln -- configfile ~/.nuget/NuGet/Nuget.Config
RUN dotnet build --configuration Release

FROM build AS publication
RUN dotnet publish --configuration Release 

# ################################################################
#                        3ª ETAPA                                #
# ================================================================
# Publicação das aplicações.                                     #
# ================================================================
FROM base AS final

WORKDIR /app

USER susep
# Para obter privilégios de root, no container use: sudo -i

COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.WebApi/bin/Release/netcoreapp3.1/publish /app/api/
COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.ApiGateway/bin/Release/netcoreapp3.1/publish /app/gateway/
COPY --chown=susep:sispg --from=publication /src/Susep.SISRH.WebApp/bin/Release/netcoreapp3.1/publish /app/app/