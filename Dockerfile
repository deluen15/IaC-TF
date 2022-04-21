FROM openjdk:16-alpine3.13
LABEL maintainer="endri.zeqo@gmail.com"
RUN apk add maven
WORKDIR /app
COPY . /app/
RUN mvn -f /app/pom.xml clean install -DskipTests
WORKDIR /app
COPY target/${JAR_FILE} /usr/share/${JAR_FILE}
#VOLUME /main-app
#ADD target/aksIaC.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/share/IaC-TF-0.0.1-SNAPSHOT.jar"]

