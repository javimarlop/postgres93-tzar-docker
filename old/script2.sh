docker build -t pg_with_my_stuff .
docker run -d --name my_postgres -p 5432:5432 pg_with_my_stuff
docker logs -f my_postgres

psql -h 127.0.0.1 -U docker docker

