FROM bhlx3lyx7/env:0.1.6
MAINTAINER org.apache.griffin

WORKDIR /root

ADD prep /root

# files into hdfs
RUN chmod 755 prepare.sh
RUN /etc/bootstrap.sh && ./prepare.sh && rm prepare.sh

# init
RUN cd init && ./mysql-init.sh

# entrypoint
ADD bootstrap-all.sh /etc/
RUN chmod 755 /etc/bootstrap-all.sh

ENTRYPOINT ["/etc/bootstrap-all.sh"]
