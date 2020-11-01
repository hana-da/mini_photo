FROM rubylang/ruby:2.7.2-bionic

MAINTAINER hana-da <hana-da@users.noreply.github.com>
ENV APP_HOME=/mini_photo

ENV PATH=$APP_HOME/bin:$PATH \
    # from https://devcenter.heroku.com/articles/ruby-support#rails-6-x-applications
    NODE_VERSION=v12.16.2 \
    YARN_VERSION=v1.22.4
WORKDIR $APP_HOME

RUN set -ex \
    && forRubyGems=' \
        # for sassc
        g++ \
        # for sqlite3
        libsqlite3-dev \
      ' \
    && forYarnInstallation=' \
        nodejs \
        npm \
        curl \
      ' \
    && apt-get update \
    && apt-get install -y $forRubyGems $forYarnInstallation \
    && npm install -g n \
    # install node and yarn via n
    && n ${NODE_VERSION} \
    && npm install -g yarn@${YARN_VERSION} \
    && apt-get purge -y $forYarnInstallation \
    # clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*
