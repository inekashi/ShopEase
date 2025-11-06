# Use OpenJDK 17
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy JAR built by Maven
COPY target/E-Commerce-Backend-0.0.1-SNAPSHOT.jar app.jar

# Expose port your Spring Boot app runs on
EXPOSE 8009

# Run the JAR
ENTRYPOINT ["java","-jar","app.jar"]
