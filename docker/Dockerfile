FROM debian:stretch
LABEL maintainer="Nudi Developers <dev@fsocietychain.com>"
LABEL description="Dockerised NudiCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
