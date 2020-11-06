FROM ruby:2.7.1

RUN apt-get update
RUN apt-get -y install nodejs

RUN mkdir /mi_comercio_api
WORKDIR /mi_comercio_api
