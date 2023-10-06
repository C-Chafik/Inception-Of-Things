FROM alpine:latest

RUN apk update
RUN apk upgrade

RUN apk add curl

RUN apk add --update docker openrc
RUN rc-update add docker boot

RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

ENTRYPOINT ["bash", "dockerscript.sh"]