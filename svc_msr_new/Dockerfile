FROM bhlx3lyx7/env:0.2.0
MAINTAINER org.apache.griffin

WORKDIR /root

ADD prep /root

# files into hdfs
RUN chmod 755 prepare.sh
RUN /etc/bootstrap.sh && ./prepare.sh && rm prepare.sh

#install postgresql
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get -y -q install python-software-properties software-properties-common \
    && apt-get -y -q install postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf
EXPOSE 5432

#init
RUN cp init/postgresql_table_init.sql /var/lib/postgresql/init.sql
USER postgres
WORKDIR /var/lib/postgresql
RUN /etc/init.d/postgresql start \
    && psql --command "CREATE USER griffin WITH SUPERUSER PASSWORD '123456';" \
    && createdb -O griffin quartz \
    && echo "localhost:5432:quartz:griffin:123456" > .pgpass && chmod 600 .pgpass \
    && psql -p 5432 -h localhost -U griffin -f init.sql quartz
USER root
WORKDIR /root

# entrypoint
ADD bootstrap-all.sh /etc/
RUN chmod 755 /etc/bootstrap-all.sh

ENTRYPOINT ["/etc/bootstrap-all.sh"]
