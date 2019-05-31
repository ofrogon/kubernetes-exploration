FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS base
EXPOSE 80
EXPOSE 443

COPY . /app/src
WORKDIR /app/src
RUN dotnet restore
RUN dotnet build -c Release
RUN dotnet publish -c Release -o /app/published

WORKDIR /app
COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
CMD /bin/bash ./entrypoint.sh