Microservices Template Repo
---

## Table of contents
1. [Project Structure](#project-structure)
2. [Local Setup](#local-setup)
3. [Shared Dependencies using Conventions](#shared-dependencies-using-conventions)
   1. [Services Conventions](#services-conventions)
   2. [Code Quality Conventions](#code-quality-conventions)
4. [Checks](#checks)

## Project Structure

```Root project 'microtemprepo'
root/
└── services/
    ├── buildSrc/               --- common build logic
    │   └── src/main/groovy     --- convention plugins and shared dependencies
    ├── scripts/                --- build scripts
    ├── service1/               --- microservice gradle project
    ├── service2/               --- microservice gradle project
    ├── shared/                 
    │   └── shared1/            --- shared lib gradle project
    ├── .env                    --- env for local setup
    └── docker-compose.yml      --- docker compose for local setup
```
Java Framework - Spring boot 3.3.4, Spring security resource server
ORM - Hibernate 6.5.3.Final
Database - Postgres 16.4
Database Version and Migrations - Flyway
Testing framework - Test containers with Junit 5

## Local Setup
This application can run in both you IDE as a jar or as a docker image. Google jib is used create a service container in the host machines local docker repository, following which the docker compose file can be used to manage all service images along with the single postgres db. Each service creates its own schema in the PostgresDB.

### First-time Repo setup
Under the service projects, look through the initial flyway migration script and update the schema name / table to be generated. 

### Build and run service images

#### Run services using docker compose
Under the services folder run the following command to create docker images of all services - 
`./scripts/buildWithEnv.sh jibDockerBuild`

Start the docker compose using - `docker-compose up -d`
Stop the docker compose using - `docker-compose down`

#### Run service in Intellij
1. Open project in Intellij from the services folder
2. Under the Run/Debug configurations create a new configuration with all environment variables from the .env file for gradle service you would like to run - `:service1:bootRun`
3. Create service images - `./scripts/buildWithEnv.sh jibDockerBuild` OR comment out service1 / service2 sections in docker-compose.
4. Start the DB using docker compose using - `docker-compose up -d`
5. Clean build directories `./gradlew clean`
6. Start the application using gradle task `:service1:bootRun`

## Shared Dependencies using conventions
Dependencies are shared using the [convention plugins](https://docs.gradle.org/current/userguide/sharing_build_logic_between_subprojects.html#sec:convention_plugins) pattern recommended by Gradle.

### Services Conventions
The service convention plugin is located at buildSrc/src/main/groovy/microrepo.service-conventions.gradle.
Contains all shared dependencies required for each microservice.

### Code Quality Conventions
The code quality convention plugin is located at buildSrc/src/main/groovy/microrepo.code-quality-conventions.gradle.
Contains all code quality check plugins -
1. Code Formatting - [Spotless](https://github.com/diffplug/spotless) with [Palantir](https://github.com/palantir/palantir-java-format)
2. Code Coverage - [Jacoco]()
3. Legacy API detection - [Modernizer](https://github.com/andygoossens/gradle-modernizer-plugin)
4. Enforce HTTPS for APIs - [nohttp](https://github.com/spring-io/nohttp)

## Checks
1. Spotless check - `./scripts/buildWithEnv.sh spotlessCheck `
2. Jacoco code coverage generation - `./scripts/buildWithEnv.sh jacocoTestReport`
3. Jacoco code coverage check - `./scripts/buildWithEnv.sh jacocoTestCoverageVerification`
4. Legacy API Check - `./scripts/buildWithEnv.sh modernizer`



