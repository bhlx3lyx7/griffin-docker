#!/bin/bash

#create table
hive -f create-table.hql
echo "create table done"

hive -f insert-data.hql
echo "insert data [$partition_date] done"

