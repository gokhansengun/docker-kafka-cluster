## Introduction

Creates a Kafka Cluster with 3 Brokers also 3 Zookeeper nodes.

## Usage

### Creating the Cluster

Run `make setup-cluster` to create the cluster with 3 Kafka Brokers and 3 Zookeeper nodes.

### Insert test values into a topic

Run `make produce-dataset` to produce 1000 values.

### Read test values from the topic

RUN `make consume-dataset` to consume the values back.

### Querying the Cluster 

Run `make query-cluster` to query the cluster.

## Troubleshooting

Run `make logs` to see logs from the services and follow them.

## Todo

