# DOCKER section
init:
	docker-compose run --no-deps serve rails new . --force --database=data
build:
	docker-compose build

up:
	DB_USER='root' DB_PASSWORD='' docker-compose up
down:
	docker-compose down

serve:
	docker-compose run -e DB_USER='root' -e DB_PASSWORD='' serve /bin/bash

