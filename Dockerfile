# Step : Test and package
FROM maven:3.6.0-jdk-11-slim as target
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ /build/src/
RUN mvn package -DskipTests -Dmaven.test.skip=true

# Step : Package image
FROM openjdk:11-jre-slim
EXPOSE 3333
CMD exec java $JAVA_OPTS -jar /app/api_usuario_aws.jar
COPY --from=target /build/target/api_usuario_aws.jar /app/api_usuario_aws.jar