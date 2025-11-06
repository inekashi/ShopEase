# Use OpenJDK 17
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies (offline mode)
COPY E-Commerce-Backend/pom.xml .
RUN apt-get update && apt-get install -y maven
RUN mvn dependency:go-offline

# Copy source code
COPY E-Commerce-Backend/src ./src

# Package the app
RUN mvn clean package -DskipTests

# Expose the port your Spring Boot app uses
EXPOSE 8009

# Run the Spring Boot jar
CMD ["java", "-jar", "target/E-Commerce-Backend-0.0.1-SNAPSHOT.jar"]
