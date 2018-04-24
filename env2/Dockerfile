FROM ubuntu:14.04
MAINTAINER org.apache.griffin

#install wget, ssh, unzip
RUN apt-get update && apt-get install wget -y && apt-get install openssh-client openssh-server -y && apt-get install unzip curl -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install mysql-server -y && DEBIAN_FRONTEND=noninteractive apt-get install libmysql-java -y
RUN mkdir /apache 
WORKDIR /apache
ADD prep /apache
ADD conf /apache/conf

EXPOSE 2122

#ssh-config
RUN ./ssh-config.sh

#software install
RUN ./software-install.sh
RUN ./dir.sh && ./software-config.sh

ENV JAVA_HOME /apache/jdk
ENV HADOOP_HOME /apache/hadoop
ENV HADOOP_INSTALL $HADOOP_HOME
ENV HADOOP_MAPRED_HOME $HADOOP_HOME
ENV HADOOP_COMMON_HOME $HADOOP_HOME
ENV HADOOP_HDFS_HOME $HADOOP_HOME
ENV YARN_HOME $HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR $HADOOP_HOME/lib/native
ENV SCALA_HOME /apache/scala
ENV SPARK_HOME /apache/spark
ENV HIVE_HOME /apache/hive
ENV HADOOP_USER_CLASSPATH_FIRST true
ENV LIVY_HOME /apache/livy

ENV PATH $JAVA_HOME/bin:$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SCALA_HOME/bin:$SPARK_HOME/bin:$HIVE_HOME/bin:$LIVY_HOME/bin

EXPOSE 3306
EXPOSE 9000 10020
EXPOSE 50010 50020 50070 50075 50090
EXPOSE 19888
EXPOSE 8030 8031 8032 8033 8040 8042 8088
EXPOSE 49707
EXPOSE 9083 27017 6066
EXPOSE 8080
EXPOSE 8998
EXPOSE 5432

#mysql init
RUN ln -s /usr/share/java/mysql-connector-java.jar $HIVE_HOME/lib/mysql-connector-java.jar && ln -s /usr/share/java/mysql.jar $HIVE_HOME/lib/mysql.jar
RUN cd /apache/conf/mysql && cp bind_0.cnf /etc/mysql/conf.d/bind_0.cnf && ./mysql-init.sh

#postgresql init
USER postgres
WORKDIR /var/lib/postgresql
RUN /etc/init.d/postgresql start \
    && psql --command "CREATE USER griffin WITH SUPERUSER PASSWORD '123456';" \
    && createdb -O griffin quartz \
    && echo "localhost:5432:quartz:griffin:123456" > .pgpass && chmod 600 .pgpass
USER root
WORKDIR /root

#bootstrap
ADD bootstrap.sh /etc/
RUN chmod 755 /etc/bootstrap.sh

#initial
RUN hdfs namenode -format
RUN /etc/bootstrap.sh && /apache/hdfs_file.sh && rm /apache/*.sh

#bootstrap-all
ADD bootstrap-all.sh /etc/
RUN chmod 755 /etc/bootstrap-all.sh

ENTRYPOINT ["/etc/bootstrap-all.sh"]
