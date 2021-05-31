# Container image that runs your code
FROM alpine:latest

RUN apk add curl && \
    wget -P /usr/local/bin/ http://gosspublic.alicdn.com/ossutil/1.7.3/ossutil64 && \
    chmod +x /usr/local/bin/ossutil64

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]