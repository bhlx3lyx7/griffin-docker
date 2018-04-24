#!/bin/bash

find /var/lib/mysql -type f -exec touch {} \; && service mysql start

mysql -u root < hive-metastore-init.sql

# init hive metastore schema
schematool -dbType mysql -initSchema
