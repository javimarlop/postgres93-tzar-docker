# # http://docs.docker.com/examples/postgresql_service/
# On the terminal
docker run -dP --name pg javimarlop/postgres93-tzar-docker
psql -h 0.0.0.0 -p 49153 -d docker -U docker --password -c "create user tzar with password 'tzar'"
psql -h 0.0.0.0 -p 49153 -d docker -U docker --password -c "create database tzar"
psql -h 0.0.0.0 -p 49153 -d docker -U docker --password -c "GRANT ALL PRIVILEGES ON DATABASE tzar to tzar"
psql -h 0.0.0.0 -p 49153 -d tzar -U tzar --password -f db_schema.sql
# psql:db_schema.sql:344: ERROR:  must be member of role "postgres"
# connect!
psql -h 0.0.0.0 -p 49153 -d tzar -U tzar --password

