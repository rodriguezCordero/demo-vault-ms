# ---------------------------------------------------------------------------
# 1. Build stage  ────────────────────────────────────────────────────────────
#    Compila el microservicio y genera el *fat-jar* usando Maven.
# ---------------------------------------------------------------------------
FROM maven:3.9.7-eclipse-temurin-21 AS build
WORKDIR /workspace

# Copiamos primero descriptor y dependencias para aprovechar layer-cache
COPY pom.xml .
RUN mvn -B dependency:go-offline

# Ahora sí, todo el código
COPY src ./src
RUN mvn -B clean package -DskipTests

# ---------------------------------------------------------------------------
# 2. Runtime stage  ──────────────────────────────────────────────────────────
#    Imagen ligera (JRE) y usuario no-root.
# ---------------------------------------------------------------------------
FROM eclipse-temurin:21-jre-jammy

# Buenas prácticas OCI
LABEL org.opencontainers.image.title="ms1" \
      org.opencontainers.image.description="Spring Boot PoC que consume secretos desde Vault" \
      org.opencontainers.image.authors="tu-nombre" \
      org.opencontainers.image.source="https://github.com/<tu-usuario>/demo-vault-ms"

# Usuario no privilegiado
USER 1001
WORKDIR /app

# Copiamos el jar recién empaquetado
COPY --from=build /workspace/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

