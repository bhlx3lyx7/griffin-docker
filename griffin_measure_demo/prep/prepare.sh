#!/bin/bash

hadoop fs -mkdir /griffin
hadoop fs -mkdir /griffin/json
hadoop fs -mkdir /griffin/persist
hadoop fs -mkdir /griffin/checkpoint

hadoop fs -mkdir /griffin/data
hadoop fs -mkdir /griffin/data/batch

#jar file
hadoop fs -put jar/griffin-measure.jar /griffin/

#data

#service

#job
cp jar/griffin-measure.jar job/accu/
cp jar/griffin-measure.jar job/prof/
