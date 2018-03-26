# Kafka and Zookeeper

FROM java:openjdk-8-jre

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 1.0.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
ENV KAFKA_ZOOKEEPER_CONNECT localhost:2181
ENV ES_JAVA_OPTS -Xmx256m -Xms256m

# Install Kafka, Zookeeper and other needed things
RUN apt-get update && \
    apt-get install -y zookeeper wget supervisor dnsutils && \
    apt-get -qq install net-tools && \
    apt-get -qq install vim && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN curl http://apache.mirrors.spacedump.net/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -o /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

RUN tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt
RUN rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

# Start Kafka #
ADD scripts/start-kafka.sh /usr/bin/start-kafka.sh

# Supervisor config
ADD supervisor/kafka.conf supervisor/zookeeper.conf /etc/supervisor/conf.d/

# 2181 is zookeeper, 9092 is kafka
EXPOSE 2181 9092

CMD ["supervisord", "-n"]
