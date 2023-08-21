FROM centos:latest

ENV JAVA_WEBSERVER_DEPLOY_DIR=/opt/java-webserver

RUN yum -y update && \
    mkdir -p ${JAVA_WEBSERVER_DEPLOY_DIR} && \
    yum -y install java-11-openjdk-devel && \
    yum clean all

WORKDIR .
# This copies to local fat jar inside the image
ADD ./target/*.jar ${JAVA_WEBSERVER_DEPLOY_DIR}/
RUN chmod -R 755 ./
#chmod -R 777 ./


EXPOSE 8080
