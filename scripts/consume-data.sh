#!/bin/bash -e

echo "Consuming from Kafka topic $1 --"

docker-compose run --rm kafka-cat -C -b kafka-01:9092,kafka-02:9092,kafka-03:9092 -t $1
