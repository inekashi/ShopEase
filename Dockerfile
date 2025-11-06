# Stage 1: Build the project using Maven + JDK
FROM maven:3.9.2-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the project and skip tests
RUN mvn clean package -DskipTests

# Stage 2: Run the Spring Boot app
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/E-Commerce-Backend-0.0.1-SNAPSHOT.jar app.jar

# Expose the port Spring Boot will run on
EXPOSE 8009

# Set PostgreSQL environment variables from Render
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://${DATABASE_HOST}:${DATABASE_PORT}/${DATABASE_NAME}
ENV SPRING_DATASOURCE_USERNAME=${DATABASE_USER}
ENV SPRING_DATASOURCE_PASSWORD=${DATABASE_PASSWORD}
ENV SERVER_PORT=8009

# Run the JAR
ENTRYPOINT ["java","-jar","app.jar"]
