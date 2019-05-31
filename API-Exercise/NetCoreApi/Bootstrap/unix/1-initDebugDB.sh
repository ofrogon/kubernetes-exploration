#!/bin/bash 
ContainerName=sql1
SQLServerPassword=TestPassword1!
docker container stop "$ContainerName"
docker container rm "$ContainerName"
docker run -e ACCEPT_EULA=Y -e "SA_PASSWORD=$SQLServerPassword" -p 1433:1433 --name "$ContainerName" -d mcr.microsoft.com/mssql/server:2017-latest