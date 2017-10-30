#!/bin/bash

# spark dir
hadoop fs -mkdir -p /home/spark_lib
hadoop fs -put $SPARK_HOME/lib/spark-assembly-1.6.0-hadoop2.6.0.jar /home/spark_lib/
hadoop fs -chmod 755 /home/spark_lib/spark-assembly-1.6.0-hadoop2.6.0.jar

# yarn dir
hadoop fs -mkdir -p /yarn-logs/logs
hadoop fs -chmod g+w /yarn-logs/logs

# hive dir
hadoop fs -mkdir /tmp
hadoop fs -mkdir /user
hadoop fs -mkdir /user/hive
hadoop fs -mkdir /user/hive/warehouse
hadoop fs -chmod g+w /tmp
hadoop fs -chmod g+w /user/hive/warehouse

# livy dir
hadoop fs -mkdir /livy

hadoop fs -put $SPARK_HOME/lib/datanucleus*.jar /livy/
