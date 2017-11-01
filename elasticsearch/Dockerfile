FROM elasticsearch:5
MAINTAINER org.apache.griffin

WORKDIR /usr/share/elasticsearch
RUN echo 'http.cors.enabled: true' >> config/elasticsearch.yml
RUN echo 'http.cors.allow-origin: "*"' >> config/elasticsearch.yml
