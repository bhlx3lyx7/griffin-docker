#!/bin/bash

service mysql start

mysql -u root < quartz-init.sql
mysql -u griffin -p123456 -D quartz < quartz-table-init.sql
