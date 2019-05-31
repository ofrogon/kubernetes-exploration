#!/bin/bash

set -e

cd /app/src
until dotnet ef database update; do
>&2 echo "Waiting for SQL server migrations..."
sleep 1
done
>&2 echo "project migrations completed - executing command"

cd /app/published
dotnet PassengersApi.dll