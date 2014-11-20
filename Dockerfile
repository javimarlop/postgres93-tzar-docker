# vim:set ft=dockerfile:
FROM debian:wheezy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r postgres && useradd -r -g postgres postgres

# grab gosu for easy step-down from root
RUN apt-get update && apt-get install -y curl wget && rm -rf /var/lib/apt/lists/* \
	&& curl -o /usr/local/bin/gosu -SL 'https://github.com/tianon/gosu/releases/download/1.1/gosu' \
	&& chmod +x /usr/local/bin/gosu \
	&& apt-get purge -y --auto-remove curl

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN mkdir /docker-entrypoint-initdb.d

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

ENV PG_MAJOR 9.1
ENV PG_VERSION 9.1.14-1.pgdg70+1

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update \
	&& apt-get install -y postgresql-common \
	&& sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
	&& apt-get install -y \
		postgresql-$PG_MAJOR=$PG_VERSION \
		postgresql-contrib-$PG_MAJOR=$PG_VERSION \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

COPY ./db_schema.sql /tmp/db_schema.sql

#RUN wget https://tzar-framework.googlecode.com/svn/trunk/db/db_schema.sql -O /tmp/db_schema.sql
RUN service postgresql start && \
  su postgres sh -c "createuser -d -r -s tzar" && \
  su postgres sh -c "createdb -O tzar tzar" && \
  su postgres sh -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE tzar to tzar" && \
  su postgres sh -c "psql -f /tmp/db_schema.sql tzar -U tzar;\""

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
