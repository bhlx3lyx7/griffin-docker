#!/bin/bash

# java 8
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz \
-O jdk8-linux-x64.tar.gz
tar -xvzf jdk8-linux-x64.tar.gz
ln -s jdk1.8.0_131 jdk

# postgresql
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
apt-get update && apt-get -y -q install python-software-properties software-properties-common \
&& apt-get -y -q install postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3
echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# hadoop
wget http://mirror.cogentco.com/pub/apache/hadoop/common/hadoop-2.6.5/hadoop-2.6.5.tar.gz
tar -xvf hadoop-2.6.5.tar.gz
ln -s hadoop-2.6.5 hadoop

# scala
wget https://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz
tar -xvf scala-2.11.8.tgz
ln -s scala-2.11.8 scala

# spark
wget http://archive.apache.org/dist/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.6.tgz
tar -xvf spark-2.2.1-bin-hadoop2.6.tgz
ln -s spark-2.2.1-bin-hadoop2.6 spark

# hive
wget https://www.apache.org/dist/hive/hive-2.2.0/apache-hive-2.2.0-bin.tar.gz
tar -xvf apache-hive-2.2.0-bin.tar.gz
ln -s apache-hive-2.2.0-bin hive

# livy
wget http://archive.cloudera.com/beta/livy/livy-server-0.3.0.zip
unzip livy-server-0.3.0.zip
ln -s livy-server-0.3.0 livy

#elasticsearch
#wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.0.deb
#dpkg -i elasticsearch-5.4.0.deb
#update-rc.d elasticsearch defaults

#remove install packages
rm jdk8-linux-x64.tar.gz hadoop-2.6.5.tar.gz scala-2.11.8.tgz spark-2.2.1-bin-hadoop2.6.tgz apache-hive-2.2.0-bin.tar.gz livy-server-0.3.0.zip

#remove extra files
rm -rf hadoop/share/doc
