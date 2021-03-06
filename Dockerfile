FROM ruby:2.6.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
    postgresql-client vim nodejs yarn \
    && rm -rf /var/lib/apt/lists

ENV BUNDLE_PATH /gems
ENV APP_NAME store_front
ENV APP_PATH /usr/src/app
ENV PATH $APP_PATH/bin:$PATH

WORKDIR $APP_PATH

ADD . $APP_PATH

ENV RAILS_ENV development

RUN  bundle check || bundle install

CMD ./lib/docker-entrypoint.sh