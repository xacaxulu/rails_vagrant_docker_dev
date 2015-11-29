FROM ubuntu:14.04

MAINTAINER James Denman <james.denman@levvel.io>

EXPOSE 3000
RUN apt-get -qy update
RUN apt-get -qy upgrade

RUN apt-get -qy install build-essential
RUN apt-get -qy install wget
RUN apt-get -qy install curl
RUN apt-get -qy install nodejs
RUN apt-get -qy install git
RUN apt-get -qy install libmagickwand-dev 
RUN apt-get -qy install libmagickcore-dev
RUN apt-get -qy install libcurl4-openssl-dev
RUN apt-get -qy install libreadline-gplv2-dev
RUN apt-get -qy install libssl-dev
RUN apt-get -qy install libxml2-dev
RUN apt-get -qy install libxslt1-dev
RUN apt-get -qy install zlib1g-dev
RUN apt-get -qy install libyaml-dev
RUN apt-get -qy install libpq-dev
RUN apt-get -qy install openjdk-7-jre

WORKDIR /tmp

RUN wget ftp://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz
RUN tar xvfz ruby-2.1.3.tar.gz

WORKDIR ./ruby-2.1.3

RUN ./configure
RUN make
RUN make install
RUN gem install bundler --no-ri --no-rdoc

RUN apt-get -qy clean

RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN gem install bundler && bundle install --jobs 20 --retry 5
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]