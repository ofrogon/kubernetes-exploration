#!/bin/bash 
RootFolder=$PWD/../..
dockerKubeFolder=%RootFolder%/docker-kube

cd "$dockerKubeFolder"
kubectl create namespace api
kubectl passengersapi.yml