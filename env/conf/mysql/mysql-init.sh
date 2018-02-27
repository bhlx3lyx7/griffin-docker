#!/bin/bash

find /var/lib/mysql -type f -exec touch {} \; && service mysql start

sed -i.bak s/^.*"hive-txn-schema-0.13.0.mysql.sql".*/"SOURCE \/apache\/hive\/scripts\/metastore\/upgrade\/mysql\/hive-txn-schema-0.13.0.mysql.sql;"/ /apache/hive/scripts/metastore/upgrade/mysql/hive-schema-1.2.0.mysql.sql

mysql -u root < hive-metastore-init.sql

