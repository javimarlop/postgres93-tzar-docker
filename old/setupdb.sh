postgres sh -c "createuser tzar with password 'tzar'" && \
postgres sh -c "createdb -O tzar tzar" && \
postgres sh -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE tzar to tzar" && \
postgres sh -c "psql -f /tmp/db_schema.sql tzar -U tzar;\""
