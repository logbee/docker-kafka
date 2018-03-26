# docker-kafka #

Notice: This project was forked from https://github.com/spotify/docker-kafka.

Additional features may be included from
https://github.com/spotify/docker-kafka/pull/71 and https://github.com/spotify/docker-kafka/pull/29 to create topics on start.

# Docker container for Kafka #
This cointainer was built for testing the logbee/keyscore project without having the need of a actual running kafka instance on a physical machine.

## Build image from Dockerfile ##
Build the image in the docker-kafka directory:
```bash
docker build .
```

When you are behind a proxy, pass your proxy settings to the build command. e.g.:
```bash
docker build . --build-arg http_proxy=http://172.17.0.1:3128/ --build-arg https_proxy=https://172.17.0.1:3128/
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



