### API-exercise
I had to evaluate a developper case for dotnet in the context of my current position, so I took the time to find the easiest way to create a rest api in dotnet core. Where I currently work we currently don't use docker and barely use dotnet core (which is a shame, really)

We want to enable developpers by giving them a toolset simple enough that they can ramp-up rapidly on the newly introduced technologies without too much fuss; it's very important that they can dive deep if they want, but be able to work with minimum knowledge if they don't want to.

The tools that are new to them are:
- docker
- kubernetes
- dotnet core in a linux context

I made a bunch of scripts to automate the differents steps of the assignment; they are at `./NetCoreApp/Bootstrap/[your matching operating system]`


### 1. Setup & fill database
open a commandline at `./NetCoreApp/Bootstrap/[your matching operating system]`:
- run `1-initDebugDB` (which create a docker container exposed to the local host containing mssql)
- run `2-seedDebugDB` (which run the migrations in a developper seeding scenario)
- enjoy!

In a development context and in aspnet core with entity framework, database migrations are mostly automated and ultra simple to run against a fresh database (even not fresh, but hey, you gotta chose the right one).

A dev would either run: `dotnet ef database update` next to `PassengerApi.csproj` in a commandline or simply run `update-database` in VS package manager console and would be done with it.


### 2. Create an API
I chose aspnet core for simplicity and previous experience in dotnet. Since aspnet core can be deployed to linux, this is a no-brainer for entreprise grade application in a full fledged application context.

It's also super easy to generate the api with its db context, it's literraly one liners commandlines (I had to find this, because I didn't knew how simple it was!)

Remaining TO-DOs:
1. separate db migrations into a separate project to be able to run it as an init container
2. secure the api with a certificate provider properly like an adult,
3. re-enable https
4. create a proper frontend to interact with the data that uses the api to access the data
5. implement proper unit tests and other tests (e2e, load, fail injection)
6. find a way to reduce docker image size and still benefit from dotnet sdk 


### 3. Dockerize
I use the script at `./NetCoreApp/Bootstrap/[your matching operating system]/3-pushDockerPackage` to build and push a new version of the api.
In a CI context, the package would be pushed with a build number instead of latest.

1. spawn a console in `./PassengersApi` folder
2. run `docker-compose build`
3. run `docker-compose up`
4. enjoy!


### 4. Deploy to Kubernetes
1. spawn a console in `./NetCoreApp/Bootstrap/[your matching operating system]`:
2. run `4-startAPIInKube`
3. swagger index should be accessible at `localhost:8082`
4. enjoy!


### 5. Whatever you can think of
1. Use HELM to configure deployments to enable differenciation in configuration depending on the environment where the app is deployed
2. use a secret per namespace to hide the sqlserver database password and/or leverage kubernetes secrets and/or a vault service to hide sensitive passwords and variables
3. choose one or more hosted kubernetes solution (GKS, AWS, AKS...) (example: AWS with Route53 provide dns and certificates faster than google; StackDriver is part of google cloud but available outside without any fuss)
4. implement terraform scripts to be able to replicate infrastructure easily
5. use istio to map services between them and kiali to view service dependencies + canary analysis
6. use spinnaker to manage deployment pipelines depending on the development flow hard binded to the git branching model
7. use ambassador to map access routes
8. use a solution like stackdriver (no vendor lock-in) to monitor and aggregate logs
