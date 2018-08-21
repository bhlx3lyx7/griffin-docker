spark-submit --class org.apache.griffin.measure.Application --master yarn --deploy-mode client --queue default \
--driver-memory 1g --executor-memory 1g --num-executors 2 \
--conf spark.yarn.executor.memoryOverhead=512 \
griffin-measure.jar \
hdfs:///griffin/json/env.json hdfs:///griffin/json/streaming-prof-config.json
