
default: develop

.PHONY: build
build:
	docker-compose build

.PHONY: develop
develop: build
	docker-compose up -d --remove-orphans

.PHONY: logs
logs:
	docker-compose logs -f

.PHONY: stop
stop:
	docker-compose kill -s SIGINT

.PHONY: deploy
deploy:
	echo "deploying"
	docker-compose run --entrypoint sh web test-entrypoint.sh
	git push
	heroku container:login
	heroku container:push web
