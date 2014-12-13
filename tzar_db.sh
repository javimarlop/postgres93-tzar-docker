RUN /etc/init.d/postgresql start
RUN psql -c "create user tzar with password 'tzar'"
RUN createdb -O tzar tzar
RUN psql -c "GRANT ALL PRIVILEGES ON DATABASE tzar to tzar"
RUN psql -f "/tmp/db_schema.sql tzar -U tzar"
