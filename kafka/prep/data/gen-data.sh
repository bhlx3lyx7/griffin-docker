#!/bin/bash

#current time
cur_time=`date +%Y-%m-%d_%H:%M:%S`
sed s/TIME/$cur_time/ ./source.temp > source.tp
sed s/TIME/$cur_time/ ./target.temp > target.tp

#create data
for row in 1 2 3 4 5 6 7 8 9 10
do
  sed -n "${row}p" < source.tp > sline
  cnt=`shuf -i1-2 -n1`
  clr="red"
  if [ $cnt == 2 ]; then clr="yellow"; fi
  sed s/COLOR/$clr/ sline >> source.data
done
rm sline

cat target.tp > target.data

rm source.tp target.tp

#import data
kafka-console-producer.sh --broker-list localhost:9092 --topic source --new-producer < source.data
kafka-console-producer.sh --broker-list localhost:9092 --topic target --new-producer < target.data

rm source.data target.data

echo "insert data at ${cur_time}"
