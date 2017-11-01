#!/bin/bash

nohup zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties > $KAFKA_HOME/zk.log &
sleep 5
nohup kafka-server-start.sh $KAFKA_HOME/config/server.properties > $KAFKA_HOME/kafka.log &

/bin/bash -c "bash"
