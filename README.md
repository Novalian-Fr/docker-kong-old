# docker-kong

From official : https://hub.docker.com/_/kong/

Version : Ubuntu-Xenial 
Version : Kong 0.11.2

## Build image

Clone the repo and do :

	docker build -t docker-kong .


## Database

Launch cassandra from dockerhub

	docker run -d --name kong-database -p 9042:9042 cassandra:3

Launch kong migration

	docker run --rm \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=cassandra" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    docker-kong kong migrations up


## Kong startup

	docker run -d --name kong \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=cassandra" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    -e "KONG_PG_HOST=kong-database" \
    -p 80:8000 \
    -p 443:8443 \
    -p 8001:8001 \
    -p 8444:8444 \
    docker-kong
