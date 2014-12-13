# http://docs.docker.com/examples/postgresql_service/
docker build -t eg_postgresql .
docker run --rm -P --name pg_test eg_postgresql
docker ps -a
psql -h localhost -p 49153 -d docker -U docker --password

docker run -tiP --name pg javimarlop/postgres93-tzar-docker /bin/bash
