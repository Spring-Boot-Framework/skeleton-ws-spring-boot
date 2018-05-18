# From the OpenJDK image
FROM openjdk:8u151-jre-alpine3.7

# Java Options
ENV JAVA_OPTS="-server -Xms1024m -Xmx1024m -XX:+UseParallelGC -verbose:gc"

# Listens to port 8080 for HTTP connections
EXPOSE 8080

# Create application base directory
RUN mkdir -p /var/lib/bootapp

# Change working directory to the application base
WORKDIR /var/lib/bootapp

# Use the Gradle build artifact(s)
COPY ./build/libs/*.jar application.jar

# Runs the executable JAR produced by the Gradle build
# Note: You may pass in environment variable key-pairs to override values 
#       in the Spring Boot application configuration using the 
#       "-e ENV_VARIABLE=value" option in the Docker Container Run command.
#       This is useful for supplying Spring Profile values or
#       any environment-specific overrides.
#
#       Example: Run the application on port 80 with ONLY the 'dm' profile:
#       docker container run --detach --publish 80:8080 -e SPRING_PROFILES_ACTIVE=dm leanstacks/greeting-ws:latest
#
CMD java $JAVA_OPTS -jar application.jar