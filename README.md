postgres93-tzar-docker
======================

It is a postgres 9.3 database server and [app](https://github.com/javimarlop/ocpu-radarplot-sochi) configured as a [tzar](https://tzar-framework.atlassian.net/wiki/display/TD/Tzar+documentation) database and installed on a Docker machine. [Docker](https://www.docker.com/) needs to be installed in your OS.

* Run `docker pull javimarlop/postgres93-tzar-docker`
* The run:

```
docker run -dP --name pg javimarlop/postgres93-tzar-docker
psql -h 0.0.0.0 -p 49153 -d docker -U docker --password -c "create user tzar with password 'tzar'"
psql -h 0.0.0.0 -p 49153 -d docker -U docker --password -c "create database tzar"
psql -h 0.0.0.0 -p 49153 -d docker -U docker --password -c "GRANT ALL PRIVILEGES ON DATABASE tzar to tzar"
psql -h 0.0.0.0 -p 49153 -d tzar -U tzar --password -f db_schema.sql
# psql:db_schema.sql:344: ERROR:  must be member of role "postgres"
# connect!
psql -h 0.0.0.0 -p 49153 -d tzar -U tzar --password
```

More info on how to connect to the DB from the host or from another container [here](http://docs.docker.com/examples/postgresql_service/).
