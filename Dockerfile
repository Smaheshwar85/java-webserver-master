# Use an official Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_WEBSERVER_DEPLOY_DIR=/opt/java-webserver

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Set working directory
WORKDIR .
# This copies to local fat jar inside the image

ADD ./target/java-webserver-1.0.0.jar .
ADD ./target/original-java-webserver-1.0.0.jar .
ADD ./target/java-webserver-1.0.0-sources.jar .
ADD ./target/java-webserver-1.0.0-javadoc.jar .
ADD  ./docroot  .

#ADD /var/lib/jenkins/workspace/pipeline-docker/docroot .

#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar
#RUN chmod -R 755 ${JAVA_WEBSERVER_DEPLOY_DIR}
#chmod -R 777 ./

# Copy your Java application JAR or code to the container
#COPY . /app

# Command to run your Java application (replace with your actual command)
CMD ["cp","docroot",".";"java", "-jar", "java-webserver-1.0.0.jar"]
#CMD ["java","-jar","/app.jar"]

EXPOSE 8085
