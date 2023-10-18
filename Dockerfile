# Utilisation de l'image Alpine Linux comme base
FROM alpine:latest

# Mise à jour des packages et installation de PowerShell Core
RUN apk update && apk add --no-cache \
    curl \
    libcurl \
    tar \
    gzip

# Téléchargement et installation de PowerShell Core
RUN curl -sSL -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-linux-alpine-x64.tar.gz
RUN tar -xzf /tmp/powershell.tar.gz -C /opt/microsoft/powershell
RUN rm /tmp/powershell.tar.gz

# Ajout de PowerShell Core au chemin d'accès
ENV PATH=$PATH:/opt/microsoft/powershell/7.1.4

# Installation du module AWS pour PowerShell

RUN pwsh -Command "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
RUN pwsh -c "Install-Module -Name AWS.Tools -Force -Scope AllUsers"
RUN pwsh -Command "Install-Module -Name SimplySql"
# Copie de votre script PowerShell dans l'image
COPY /app/script.ps1 /app/script.ps1

# Commande par défaut pour exécuter le script PowerShell
CMD [ "pwsh", "/app/script.ps1" ]
