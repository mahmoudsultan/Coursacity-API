FROM ruby:2.7.1
ENV BUNDLER_VERSION=2.1.4
RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client default-libmysqlclient-dev imagemagick netcat

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY bin/setup_app.sh /usr/bin/
RUN chmod +x /usr/bin/setup_app.sh
ENTRYPOINT ["setup_app.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
