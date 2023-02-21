#FROM c.rzp.io/proxy_dockerhub/library/golang:1.19.0-alpine3.16 as proto-builder
#FROM alpine:3.16
FROM nginx:1.23-alpine
WORKDIR /workspace/app

RUN apk add yarn
RUN apk add --no-cache bash
RUN apk add make
RUN apk add go
RUN mkdir hermes 
COPY . hermes/
WORKDIR /workspace/app/hermes
RUN make bin/linux
ENTRYPOINT ["./hermes", "server", "-config=config.hcl"]
