FROM openjdk:17-jdk-slim
ARG JAR_FILE=build/libs/EmployeeService-1.0-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "/app.jar"]
