# Étape 1 : build Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /build
COPY . .

# Build du .jar
RUN mvn clean package -DskipTests

# Étape 2 : image d'exécution
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copie du .jar — remplace avec le vrai nom
COPY --from=build /build/target/hello-world-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
