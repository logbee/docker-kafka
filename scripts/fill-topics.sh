#!/bin/bash

echo -e "Started topic filling with testdata.\n" >> /var/log/kafka-topics/kafka-topic-creation.log

if [ -n $1 ]; then
    IFS=','; for topicToFill in $1; do
        TOP=$(/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/bin/kafka-topics.sh --zookeeper localhost:2181 --list | grep -c ${topicToFill})
        if [ $TOP -eq 1 ]; then
            echo -e "[START] Filling ${topicToFill} with testdata..." >> /var/log/kafka-topics/kafka-topic-creation.log
            /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic ${topicToFill} < /mnt/testdata.json
        else
            echo -e "[ERROR] ${topicToFill} can not be filled with testdata." >> /var/log/kafka-topics/kafka-topic-creation.log
        fi
        echo -e "[DONE] Filling ${topicToFill} with testdata." >> /var/log/kafka-topics/kafka-topic-creation.log
    done
else
    echo -e "[ERROR] No topics found \n" >> /var/log/kafka-topics/kafka-topic-creation.log;
fi
echo -e "Finished topic filling with testdata.\n" >> /var/log/kafka-topics/kafka-topic-creation.log