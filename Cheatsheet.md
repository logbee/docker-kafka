# docker-kafka Cheatsheet

## General 

Show all docker containers:
```bash
    docker ps -a 
```
Show all docker images
```bash    
    docker images -a
```
Remove all docker containers:
```bash
    docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
```
Remove all docker images:
```bash
    docker rmi -f $(docker images -q)
```

## docker-kafka

Pull image from quay.io
```bash
    docker pull quay.io/logbee/docker-kafka
```

Run docker-kafka:
```bash    
    docker run -d --name kafka-docker -p 2181:2181 -p 9092:9092 --network host -v /home/foobar/docker-kafka/:/mnt/ quay.io/logbee/docker-kafka
```

Create topics:
```bash    
    docker exec ID /usr/bin/create-topics.sh "TopicA,TopicB,TopicC"
```

Fill topics:
```bash
    docker exec ID /usr/bin/fill-topics.sh "testTopic" /mnt/testdata.json
```

Go into docker container:
```bash
    docker exec -i -t ID /bin/bash
```

Start consumer:
```bash
    docker exec ID /opt/kafka_2.12-1.0.0/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic TopicA --from-beginning
```

Start producer:
```bash
    docker exec ID  /opt/kafka_2.12-1.0.0/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic TopicA
```

List topics:
```bash
    docker exec ID  /opt/kafka_2.12-1.0.0/bin/kafka-topics.sh --list --zookeeper localhost:2181
```

