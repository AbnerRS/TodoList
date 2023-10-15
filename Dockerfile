FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y

FROM openjdk:17-jdk-slim

COPY . . 

RUN apt-get install maven -y -qq
RUN mvn clean install 

EXPOSE 8080

COPY --from=build /target/todolist-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]