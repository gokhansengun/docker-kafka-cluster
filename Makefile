setup-cluster:
	docker-compose up -d zookeeper-01
	docker-compose up -d zookeeper-02
	docker-compose up -d zookeeper-03

	@echo "Sleeping for 10 seconds to wait for zookeeper nodes to be up and form a cluster"
	sleep 10
	
	docker-compose up -d kafka-01
	docker-compose up -d kafka-02
	docker-compose up -d kafka-03

clean:
	docker-compose down -v

query-cluster:
	docker-compose run --rm kafka-cat -L -b kafka-02,kafka-03

produce-dataset:
	@./scripts/produce-data.sh test-data 1000
	@echo "Produced 1000 messages on test-data topic"

consume-dataset:
	@echo "You need to press Ctrl+C to exit after consuming"
	@echo "Now press any key to continue"
	@read -n 1
	@./scripts/consume-data.sh test-data 1000

ps:
	docker-compose ps

logs:
	docker-compose logs -f