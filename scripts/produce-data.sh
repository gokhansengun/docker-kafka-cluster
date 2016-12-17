#!/bin/bash -e

for ((i=0;i<$2;++i)); do echo "Producing to Kafka topic $1 with value $i"; done | docker-compose run --rm kafka-cat -P -b kafka-01,kafka-02,kafka-03 -t $1
