#FROM openjdk:16-alpine3.13
#LABEL maintainer="endri.zeqo@gmail.com"
#VOLUME /main-app
#ADD target/IaC-TF-0.0.1-SNAPSHOT.jar app.jar
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","/app.jar"]
#
FROM openjdk:16-alpine3.13

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline

COPY src ./src
EXPOSE 8080
CMD ["./mvnw", "spring-boot:run"]
