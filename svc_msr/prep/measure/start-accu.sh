spark-submit --class org.apache.griffin.measure.Application --master yarn --deploy-mode client --queue default \
--driver-memory 1g --executor-memory 1g --num-executors 3 \
--conf spark.yarn.executor.memoryOverhead=512 \
griffin-measure.jar \
/griffin/json/env.json /griffin/json/streaming-accu-config.json hdfs,hdfs
