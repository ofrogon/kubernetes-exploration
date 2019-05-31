SET "HERE=%~dp0"
SET "RootFolder=%HERE%..\.."
SET "dockerKubeFolder=%RootFolder%\docker-kube"

cd "%dockerKubeFolder%"
call kubectl create namespace api
call kubectl passengersapi.yml