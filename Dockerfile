FROM maven:3.8.8-eclipse-temurin-11-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-alpine
WORKDIR /opt
ENV PORT 8080
EXPOSE 8080
COPY --from=build /app/target/*.jar /opt/app.jar
ENTRYPOINT exec java $JAVA_OPTS -jar app.jar
