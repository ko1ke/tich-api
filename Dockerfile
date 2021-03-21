FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
RUN mkdir /tich-api
WORKDIR /tich-api
COPY Gemfile /tich-api/Gemfile
COPY Gemfile.lock /tich-api/Gemfile.lock
RUN bundle install -j4
COPY . /tich-api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8080

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]