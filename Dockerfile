
# Folosește o imagine oficială cu JDK pentru build
FROM gradle:8.5-jdk17 AS build
WORKDIR /app

# Copiază tot codul sursă
COPY . .

# Rulează build-ul (creează jar-ul)
RUN gradle build --no-daemon

# Stage final: imagine mai mică cu JRE
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copiază jar-ul din stage-ul anterior
COPY --from=build /app/build/libs/*.jar app.jar

# Expune portul aplicației
EXPOSE 8080

# Comanda de start
ENTRYPOINT ["java", "-jar", "app.jar"]
