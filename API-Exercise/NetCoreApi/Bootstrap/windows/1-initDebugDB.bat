SET "ContainerName=sql1"
SET "SQLServerPassword=TestPassword1!"
call docker container stop "%ContainerName%"
call docker container rm "%ContainerName%"
call docker run -e ACCEPT_EULA=Y -e "SA_PASSWORD=%SQLServerPassword%" -p 1433:1433 --name "%ContainerName%" -d mcr.microsoft.com/mssql/server:2017-latest