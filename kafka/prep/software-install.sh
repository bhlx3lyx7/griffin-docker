#!/bin/bash

#kafka
wget http://apache.mirrors.hoobly.com/kafka/0.8.2.2/kafka_2.10-0.8.2.2.tgz
tar -xvzf kafka_2.10-0.8.2.2.tgz
ln -s kafka_2.10-0.8.2.2 kafka

#remove install packages
rm kafka_2.10-0.8.2.2.tgz
