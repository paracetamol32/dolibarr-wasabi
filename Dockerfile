FROM alpine:latest
RUN apk update && apk add powershell
RUN pwsh -Command "Install-Module -Name AWSPowerShell.NetCore -Force"
RUN pwsh -Command "Install-PackageProvider -Name NuGet -Force"
RUN pwsh -Command "Install-Module -Name MySql.Data -Force"

