FROM openjdk:16-alpine3.13
LABEL maintainer="endri.zeqo@gmail.com"
VOLUME /main-app
ADD target/aksIaC.jar app.jar
EXPOSE 80
ENTRYPOINT ["java","-jar","/app.jar"]

