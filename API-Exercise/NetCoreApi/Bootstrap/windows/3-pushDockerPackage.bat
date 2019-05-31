SET "HERE=%~dp0"
SET "RootFolder=%HERE%..\.."

cd "%RootFolder%"
call docker login registry.gitlab.com
call docker build -t registry.gitlab.com/fvgoulet/api-exercise/passengersapi:latest ./PassengersApi
call docker push registry.gitlab.com/fvgoulet/api-exercise/passengersapi:latest