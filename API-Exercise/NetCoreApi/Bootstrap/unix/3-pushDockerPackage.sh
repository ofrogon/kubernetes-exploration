#!/bin/bash 
RootFolder=$PWD/../..

cd "$RootFolder"
docker login registry.gitlab.com
docker build -t registry.gitlab.com/fvgoulet/api-exercise/passengersapi:latest ./PassengersApi
docker push registry.gitlab.com/fvgoulet/api-exercise/passengersapi:latest