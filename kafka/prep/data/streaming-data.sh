#!/bin/bash

#create topics
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic source
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic target

#every minute
set +e
while true
do
  ./gen-data.sh
  sleep 60
done
set -e
