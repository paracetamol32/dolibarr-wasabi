# Utilisation de l'image Alpine Linux comme base
FROM alpine:latest

# Mise à jour des packages et installation de PowerShell Core
RUN apk update && apk add --no-cache \
    curl \
    libcurl \
    tar \
    gzip  \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs  \
    curl

# Téléchargement et installation de PowerShell Core
RUN curl -sSL -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-linux-alpine-x64.tar.gz
RUN mkdir /opt/microsoft
RUN mkdir /opt/microsoft/powershell
RUN tar -xzf /tmp/powershell.tar.gz -C /opt/microsoft/powershell
RUN rm /tmp/powershell.tar.gz

# Ajout de PowerShell Core au chemin d'accès
ENV PATH=$PATH:/opt/microsoft/powershell

# Installation du module AWS pour PowerShell

RUN pwsh -Command "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
RUN pwsh -Command "Install-Module -Name AWS.Tools.Installer"
RUN pwsh -Command "Install-AWSToolsModule AWS.Tools.S3 -CleanUp"
RUN pwsh -Command "Install-Module -Name SimplySql"
# Copie de votre script PowerShell dans l'image
COPY /app/script.ps1 /app/script.ps1

# Commande par défaut pour exécuter le script PowerShell
CMD [ "pwsh", "/app/script.ps1" ]
