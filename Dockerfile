FROM openjdk:17-slim as build

COPY . .

RUN chmod +x ./gradlew && \
    ./gradlew clean build --info

FROM openjdk:17-slim as main

WORKDIR /app

ENV DB_URL=${DB_HOST:-default}
ENV DB_USER=${DB_USER:-default}
ENV DB_PASSWORD=${DB_PASSWORD:-default}


COPY --from=build /build/libs/ticket_booking_app-0.0.1-SNAPSHOT.jar ./ticket_booking_app.jar

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=prod", "ticket_booking_app.jar"]