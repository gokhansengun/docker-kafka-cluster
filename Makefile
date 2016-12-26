setup-kafka-cluster: setup-zookeeper-cluster

	docker-compose up -d kafka-01
	docker-compose up -d kafka-02
	docker-compose up -d kafka-03

setup-zookeeper-cluster:
	docker-compose up -d zookeeper-01
	docker-compose up -d zookeeper-02
	docker-compose up -d zookeeper-03

	## sleep for 5 seconds for cluster to form
	@echo "Sleeping for 5 seconds to wait for zookeeper nodes to be up and form a cluster"
	@sleep 5

	## Reconfigure the cluster to let everybody know about each other
	# Setup for node zookeeper-01
	@docker-compose exec zookeeper-01 bash -c "/opt/zookeeper-3.5.0-alpha/bin/zkCli.sh -server localhost reconfig -add server.2=zookeeper-02:2888:3888:participant\;2181"
	@docker-compose exec zookeeper-01 bash -c "/opt/zookeeper-3.5.0-alpha/bin/zkCli.sh -server localhost reconfig -add server.3=zookeeper-03:2888:3888:participant\;2181"

	# Setup for node zookeeper-02
	@docker-compose exec zookeeper-02 bash -c "/opt/zookeeper-3.5.0-alpha/bin/zkCli.sh -server localhost reconfig -add server.3=zookeeper-03:2888:3888:participant\;2181"

	# Setup for node zookeeper-03
	# Nothing, should already know everybody

	## sleep for another 5 seconds for reconfigure to settle
	@echo "Sleeping for another 5 seconds for reconfigure to settle"
	@sleep 5

clean:
	docker-compose down -v

query-zookeeper-cluster:
	@docker-compose exec zookeeper-01 bash -c "echo 'stat' | nc zookeeper-01 2181"
	@echo "\n*********\n"
	@docker-compose exec zookeeper-01 bash -c "echo 'stat' | nc zookeeper-02 2181"
	@echo "\n*********\n"
	@docker-compose exec zookeeper-01 bash -c "echo 'stat' | nc zookeeper-03 2181"

query-kafka-cluster:
	@docker-compose run --rm kafka-cat -L -b kafka-01,kafka-02,kafka-03

produce-dataset:
	@echo "Producing 1000 messages on test-data topic"
	@./scripts/produce-data.sh test-data 1000
	@echo "Produced 1000 messages on test-data topic"

consume-dataset:
	@echo "Consuming all the messages - unread messages too"
	@./scripts/consume-data.sh test-data
	@echo "Consumed all the messages"

ps:
	docker-compose ps

logs:
	docker-compose logs -f
