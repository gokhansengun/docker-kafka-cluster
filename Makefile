setup-kafka-cluster: setup-zookeeper-cluster

	@echo "Sleeping for 10 seconds to wait for zookeeper nodes to be up and form a cluster"
	sleep 10
	
	docker-compose up -d kafka-01
	docker-compose up -d kafka-02
	docker-compose up -d kafka-03

setup-zookeeper-cluster:
	docker-compose up -d zookeeper-01
	docker-compose up -d zookeeper-02
	docker-compose up -d zookeeper-03

clean:
	docker-compose down -v

query-zookeeper-cluster:
	@docker-compose exec zookeeper-01 bash -c "echo 'stat' | nc zookeeper-01 2181"
	@docker-compose exec zookeeper-01 bash -c "echo 'stat' | nc zookeeper-02 2181"
	@docker-compose exec zookeeper-01 bash -c "echo 'stat' | nc zookeeper-03 2181"

query-kafka-cluster:
	@docker-compose run --rm kafka-cat -L -b kafka-01,kafka-02,kafka-03

produce-dataset:
	@echo "Producing 1000 messages on test-data topic"
	@./scripts/produce-data.sh test-data 1000
	@echo "Produced 1000 messages on test-data topic"

consume-dataset:
	@echo "You need to press Ctrl+C to exit after consuming"
	@./scripts/consume-data.sh test-data 1000

ps:
	docker-compose ps

logs:
	docker-compose logs -f
