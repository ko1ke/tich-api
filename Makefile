up:
	docker-compose up

down:
	docker-compose down

build:
	docker-compose build

c:
	docker-compose run web rails c

seed:
	docker-compose run web rails db:seed

migrate:
	docker-compose run web rails db:migrate

rollback:
	docker-compose run web rails db:rollback

rspec:
	docker-compose run web rspec

cov:
	open -a '/Applications/Google Chrome.app' coverage/index.html

correct:
	docker-compose run web rubocop --auto-correct 

.PHONY: up down build c seed migrate rollback rspec cov correct