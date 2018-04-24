FROM bhlx3lyx7/env2:0.2.0
MAINTAINER org.apache.griffin

WORKDIR /root

ADD prep /root

# files into hdfs
RUN chmod 755 prepare.sh
RUN /etc/bootstrap.sh && ./prepare.sh && rm prepare.sh

#init
RUN cp init/postgresql_table_init.sql /var/lib/postgresql/init.sql
USER postgres
WORKDIR /var/lib/postgresql
RUN /usr/lib/postgresql/9.3/bin/pg_ctl start -w -D /etc/postgresql/9.3/main/ \
    && cat /var/log/postgresql/postgresql-9.3-main.log \
    && psql -p 5432 -h localhost -U griffin -f init.sql quartz
USER root
WORKDIR /root

# entrypoint
ADD bootstrap-all.sh /etc/
RUN chmod 755 /etc/bootstrap-all.sh

ENTRYPOINT ["/etc/bootstrap-all.sh"]
