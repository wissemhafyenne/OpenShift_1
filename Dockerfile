# Étape 1 : Build avec Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /build
COPY . .

RUN mvn clean package -DskipTests && ls -lh target

# Étape 2 : Image finale pour exécuter le .jar
FROM eclipse-temurin:17-jdk

WORKDIR /app

# ⛏️ Nom exact du .jar (respecter majuscules et underscore)
COPY --from=build /build/target/Hello_world-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
