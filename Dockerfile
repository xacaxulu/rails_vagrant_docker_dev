FROM ubuntu:14.04

MAINTAINER James Denman <james.denman@levvel.io>

EXPOSE 3000
RUN apt-get -y update
RUN apt-get -y install sqlite3 libsqlite3-dev curl build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev

RUN apt-get -y update

# install python-software-properties (so you can do add-apt-repository)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common

# add brightbox's repo, for ruby2.2
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get -y update

# install ruby2.2
RUN apt-get -y install ruby2.2 ruby2.2-dev bundler nodejs phantomjs javascript-common

RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN gem install bundler && bundle install --jobs 20 --retry 5
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]