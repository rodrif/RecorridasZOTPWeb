FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ENV RAILS_ROOT /myapp
RUN mkdir $RAILS_ROOT 
WORKDIR $RAILS_ROOT
COPY . $RAILS_ROOT
RUN bundle install
RUN bundle exec rake assets:precompile