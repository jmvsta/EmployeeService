FROM openjdk:17-jdk-slim
ARG JAR_FILE=build/libs/EmployeeService-1.0-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar", "-Dspring.profiles.active=prod"]
