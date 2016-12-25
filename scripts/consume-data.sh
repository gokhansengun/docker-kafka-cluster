#!/bin/bash -e

echo "Consuming from Kafka topic $1 --"

docker-compose run --rm kafka-cat -C -b kafka-01,kafka-02,kafka-03 -t $1 -e
