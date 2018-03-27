# docker-kafka #

Notice: This project was forked from https://github.com/spotify/docker-kafka.

# Docker container for Kafka #
This cointainer was built for testing the logbee/keyscore project without having the need of a actual running kafka instance on a physical machine.

The latest image is available at https://hub.docker.com/r/logbee/kafka/ on tag v3.

## Build image from Dockerfile ##
Build the image in the docker-kafka directory:
```bash
docker build .
```

When you are behind a proxy, pass your proxy settings to the build command. e.g.:
```bash
--build-arg http_proxy=http://172.17.0.1:3128/ --build-arg https_proxy=https://172.17.0.1:3128/
```

## Run the container ##
Expose and map the following ports:
* `9092:9092` Kafka
* `2181:2181` Zookeeper

Set the network mode:
* `host` Standalone container **or**
* `bridge` Default network communication

A proper run configuration would be 
```bash
docker run -d --name kafka-docker \ 
    -p 2181:2181 -p 9092:9092 \
    --network host \
    logbee/docker-kafka
```

### Volumes ###
If you want to mount some volumes for testdata, add the following to the run command:
```bash
-v /source/folder/of/testdata/:/destination/folder/
```
This is important when you later want to fill a kafka topic with data.


## Create Topics ##
You can create one or more kafka topic(s) with the following command:
```bash
docker exec container_id /usr/bin/create-topics.sh "topic1,topic2,topic3"
```

or 
```bash
docker exec 74ddf6262496 create-topics "topic1"
```
The script takes a list of comma seperated topic names as the only argument.
This means, when you pass 
```bash
"topic1,topic2,topic3"
```
to the script, the following topics will created:
```bash
topic1
topic2
topic3
```

If a topic already exists, no new topic will be created.

You can see the output here: /var/log/kafka-topics/kafka-topic-creation.log

## Fill Topics with data ##
For testing purposes, it is usefull to fill topics with some data.
```bash
docker exec 74ddf6262496 fill-topics "topic1,topic2" /destination/folder/testdata.type
```
This will push every single line of the file via a kafka producer to the specified topic(s) if the topic exists
and the path to the data file is correct.

Again you can see the output here: /var/log/kafka-topics/kafka-topic-creation.log

# Further informations #
In our logbee/keyscore project we are using a gradle plugin for docker containers:

https://github.com/bmuschko/gradle-docker-plugin

All of the above operations can be executed with this plugin.

Additional features for topic creation may be included based on
https://github.com/spotify/docker-kafka/pull/71 and https://github.com/spotify/docker-kafka/pull/29.


[![Build Status](https://travis-ci.org/logbee/docker-kafka.svg?branch=master)](https://travis-ci.org/logbee/docker-kafka)