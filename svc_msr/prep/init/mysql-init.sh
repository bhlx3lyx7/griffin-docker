#!/bin/bash

find /var/lib/mysql -type f -exec touch {} \; && service mysql start

mysql -u root < quartz-init.sql
mysql -u griffin -p123456 -D quartz < quartz-table-init.sql
