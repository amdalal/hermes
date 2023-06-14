FROM nginx:1.23-alpine
WORKDIR /workspace/app

RUN apk add postgresql
RUN apk add postgresql-contrib
RUN (addgroup -S postgres && adduser -S postgres -G postgres || true)
RUN mkdir -p /var/lib/postgresql/data
RUN mkdir -p /run/postgresql/
RUN chown -R postgres:postgres /run/postgresql/
RUN chmod -R 777 /var/lib/postgresql/data
RUN chown -R postgres:postgres /var/lib/postgresql/data
RUN su - postgres -c "initdb /var/lib/postgresql/data"
RUN echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf

RUN apk add yarn
RUN apk add make
RUN apk add go
RUN mkdir hermes
COPY . hermes/
WORKDIR /workspace/app/hermes
RUN make bin/linux

RUN ["chmod", "+x", "entrypoint-hermes.sh"]
ENTRYPOINT ["./entrypoint-hermes.sh"]