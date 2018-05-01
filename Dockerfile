FROM ruby:2.4.1-alpine

RUN apk update && apk add --no-cache libstdc++ tzdata postgresql-client nodejs curl

# bundle in parallel
ENV BUNDLE_JOBS 4
ENV APP /app

WORKDIR $APP
COPY Gemfile* ./
RUN apk add --no-cache --virtual build-dependencies alpine-sdk linux-headers build-base ruby-dev openssh-client postgresql postgresql-dev && \
    echo 'gem: --no-document' > /etc/gemrc && \
    gem install bundler --no-ri --no-rdoc && \
    bundle install --retry 3

EXPOSE 3000

ENTRYPOINT /bin/sh
