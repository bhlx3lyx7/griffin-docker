FROM java:openjdk-8-jre
MAINTAINER org.apache.griffin

#install wget, ssh, unzip
RUN mkdir /apache 
WORKDIR /apache
ADD prep /apache

EXPOSE 2122

#software install
RUN ./software-install.sh

ENV KAFKA_HOME /apache/kafka

ENV PATH $PATH:$KAFKA_HOME/bin

EXPOSE 2181 9092

ADD bootstrap.sh /etc
RUN chmod 755 /etc/bootstrap.sh

ENTRYPOINT ["/etc/bootstrap.sh"]
