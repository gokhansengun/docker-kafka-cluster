setup-kafka-cluster: setup-zookeeper-cluster

	docker-compose up -d kafka-01
	docker-compose up -d kafka-02
	docker-compose up -d kafka-03

setup-zookeeper-cluster:
	docker-compose up -d zookeeper-01
	docker-compose up -d zookeeper-02
	docker-compose up -d zookeeper-03

	## sleep for 2 seconds for cluster to form
	@echo "Sleeping for 2 seconds to wait for zookeeper nodes to be up and form a cluster"
	@sleep 2

	## TODO: gseng - a possible Zookeeper Bug, node zookeeper-01 has to be restarted
	## because it can not make a connection zookeeper-02 although it is up
	@docker-compose kill zookeeper-01
	@docker-compose start zookeeper-01

	@echo "Sleeping for another 2 seconds to wait after recovery"
	@sleep 2

clean:
	docker-compose kill ## to stop containers immediately
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
