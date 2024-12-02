ARG RUBY_VERSION=3.2.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

RUN apt-get update -qq && apt-get install -y nodejs default-libmysqlclient-dev build-essential

FROM base AS build

WORKDIR /app

COPY Gemfile* /app/
RUN gem install bundler && bundle install
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
