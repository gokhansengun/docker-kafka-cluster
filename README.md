## Introduction

Creates a Zookeeper Cluster and Kafka Cluster with 3 Kafka brokers and 3 Zookeeper nodes.

## Usage

### Creating the Kafka Cluster

Run `make setup-kafka-cluster` to create a Kafka cluster in addition to a Zookeeper cluster.

### Creating the Zookeeper Cluster only

Run `make setup-zookeeper-cluster` to create only the Zookeeper cluster.

### Insert test values into a topic

Run `make produce-dataset` to produce 1000 values.

### Read test values from the topic

RUN `make consume-dataset` to consume the values back.

### Querying the Kafka Cluster 

Run `make query-kafka-cluster` to query the Kafka cluster.

### Querying the Zookeeper Cluster

Run `make query-zookeeper-cluster` to query the Zookeeper cluster.

## Troubleshooting

Run `make logs` to see logs from the services and follow them.

## Todo

