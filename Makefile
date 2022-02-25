# DOCKER section
build: 
	docker-compose build
serve: 
	docker-compose run serve /bin/bash
down: 
	docker-compose down
up: 
	docker-compose up
init:
        docker-compose run --no-deps serve rails new . --force --database=data
