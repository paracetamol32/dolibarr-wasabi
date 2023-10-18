FROM ubuntu

RUN apt-get update && \
    apt-get install -y curl && \
    curl https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb --output packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y powershell

RUN pwsh -Command "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
RUN pwsh -Command "Install-Module -Name AWSPowerShell.NetCore"
RUN pwsh -Command "Install-PackageProvider -Name NuGet -Force"
RUN pwsh -Command "Install-Module -Name MySql.Data -Force"

CMD ["pwsh"]



