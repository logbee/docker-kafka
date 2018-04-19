#!/bin/bash
mkdir -p /var/log/kafka-topics/testdata/
touch -c /var/log/kafka-topics/kafka-topic-creation.log
 
if [ -n $1 ]; then
    echo "Starting topic creation with [$1] ..." >> /var/log/kafka-topics/kafka-topic-creation.log;
    sleep 15s
    IFS=','; for topicToCreate in $1; do
        topicCount=$(/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/bin/kafka-topics.sh --zookeeper localhost:2181 --list | grep -c ${topicToCreate})
        if [ $topicCount -ge 1 ]; then
            echo -e "[ERROR] Topic [${topicToCreate}] already exists.\n" >> /var/log/kafka-topics/kafka-topic-creation.log;
        else
            echo -e "\nCreating topic: [${topicToCreate}] in [$KAFKA_HOME] with zookeeper [$KAFKA_ZOOKEEPER_CONNECT] ..." >> /var/log/kafka-topics/kafka-topic-creation.log;
            $KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper $KAFKA_ZOOKEEPER_CONNECT --replication-factor 1 --partitions 1 --topic ${topicToCreate} >> /var/log/kafka-topics/kafka-topic-creation.log;
        fi
    done
    echo -e "\nTopic [${topicToCreate}] creation finished.\n" >> /var/log/kafka-topics/kafka-topic-creation.log;
else
    echo -e "[ERROR] No topics found \n" >> /var/log/kafka-topics/kafka-topic-creation.log;
fi    



