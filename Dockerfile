FROM ruby:3.1.0
MAINTAINER Henrique Morato<contato@henriquemorato.com.br>

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends \
      vim \
      postgresql-client \
      locales

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LC_ALL="en_US.utf8"
RUN export VISUAL=vim
RUN export EDITOR="$VISUAL"

WORKDIR /bugle_app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler -v 2.3.3
RUN bundle install
RUN gem install bundler-audit

COPY . .
