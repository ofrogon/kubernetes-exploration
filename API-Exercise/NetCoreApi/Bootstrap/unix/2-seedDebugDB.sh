#!/bin/bash 
cd "$PWD/../../PassengersApi"
echo $PWD
echo "Migrating database..."
dotnet ef database update