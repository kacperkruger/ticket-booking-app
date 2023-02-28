FROM openjdk:17-slim as build

COPY . .

RUN chmod +x ./gradlew && \
    ./gradlew clean build --info

FROM openjdk:17-slim as main

WORKDIR /app

COPY --from=build /build/libs/ticket-booking-app-0.0.1-SNAPSHOT.jar ./ticket-booking-app.jar

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=prod", "ticket-booking-app.jar"]