FROM openjdk:8-jdk-alpine



# Install Maven dependencies
RUN apk add --no-cache curl tar

# Set Maven version
ARG MAVEN_VERSION=3.9.3
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

# Download and install Maven
RUN mkdir -p /opt/maven \
    && curl https://dlcdn.apache.org/maven/maven-3/3.9.3/binaries/apache-maven-3.9.3-bin.tar.gz  | tar -xzC /opt/maven --strip-components=1 \
    && ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Set Maven home and path
ENV MAVEN_HOME /opt/maven
ENV PATH $MAVEN_HOME/bin:$PATH



# Copy the application JAR file
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# Set the entrypoint
ENTRYPOINT ["java","-jar","/app.jar"]

