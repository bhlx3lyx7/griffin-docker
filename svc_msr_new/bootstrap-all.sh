#!/bin/bash

$HADOOP_HOME/etc/hadoop/hadoop-env.sh
rm /tmp/*.pid

cd $HADOOP_HOME/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

find /var/lib/mysql -type f -exec touch {} \; && service mysql start
/etc/init.d/postgresql start

sed s/HOSTNAME/$HOSTNAME/ $HADOOP_HOME/etc/hadoop/core-site.xml.template > $HADOOP_HOME/etc/hadoop/core-site.xml
sed s/HOSTNAME/$HOSTNAME/ $HADOOP_HOME/etc/hadoop/yarn-site.xml.template > $HADOOP_HOME/etc/hadoop/yarn-site.xml
sed s/HOSTNAME/$HOSTNAME/ $HADOOP_HOME/etc/hadoop/mapred-site.xml.template > $HADOOP_HOME/etc/hadoop/mapred-site.xml

sed s/HOSTNAME/$HOSTNAME/ $HIVE_HOME/conf/hive-site.xml.template > $HIVE_HOME/conf/hive-site.xml

/etc/init.d/ssh start

start-dfs.sh
start-yarn.sh
mr-jobhistory-daemon.sh start historyserver


$HADOOP_HOME/bin/hdfs dfsadmin -safemode wait


hadoop fs -mkdir -p /home/spark_conf
hadoop fs -put $HIVE_HOME/conf/hive-site.xml /home/spark_conf/
echo "spark.yarn.dist.files		hdfs:///home/spark_conf/hive-site.xml" >> $SPARK_HOME/conf/spark-defaults.conf

cp $HIVE_HOME/conf/hive-site.xml $SPARK_HOME/conf/

sed s/ES_HOSTNAME/$ES_HOSTNAME/ json/env.json.template > json/env.json.temp
sed s/ZK_HOSTNAME/$ZK_HOSTNAME/ json/env.json.temp > json/env.json
rm json/env.json.temp
hadoop fs -put json/env.json /griffin/json/

sed s/KAFKA_HOSTNAME/$KAFKA_HOSTNAME/ json/streaming-accu-config.json.template > json/streaming-accu-config.json
sed s/KAFKA_HOSTNAME/$KAFKA_HOSTNAME/ json/streaming-prof-config.json.template > json/streaming-prof-config.json
hadoop fs -put json/streaming-accu-config.json /griffin/json/
hadoop fs -put json/streaming-prof-config.json /griffin/json/

$SPARK_HOME/sbin/start-all.sh

nohup hive --service metastore > metastore.log &

nohup livy-server > livy.log &

#data prepare
cd /root/data
nohup ./gen-hive-data.sh > hive-data.log &
cd /root

#start service
sed s/ES_HOSTNAME/$ES_HOSTNAME/ /root/service/config/application.properties.template > /root/service/config/application.properties.temp
sed s/HOSTNAME/$HOSTNAME/ /root/service/config/application.properties.temp > /root/service/config/application.properties
rm /root/service/config/application.properties.temp
cd /root/service
nohup java -jar service.jar > service.log &
cd /root

/bin/bash -c "bash"
