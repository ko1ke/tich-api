up:
	docker-compose up

down:
	docker-compose down

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

.PHONY: up down c seed migrate rollback rspec