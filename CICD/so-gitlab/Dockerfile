FROM hseeberger/scala-sbt:8u222_1.3.5_2.13.1 AS builder

WORKDIR /app
COPY . /app

RUN sbt compile test

RUN sbt assembly

RUN JAR_FILE=$(find /app/target/scala-* -name "*.jar" | head -n 1) && \
    cp "$JAR_FILE" /app/app.jar

# Stage 2: Application Stage (lightweight Java image)
FROM openjdk:11-jre-slim AS app
WORKDIR /app
COPY --from=builder /app/app.jar /app/app.jar
EXPOSE 8081



# Run the application
CMD ["java", "-jar", "app.jar"]
