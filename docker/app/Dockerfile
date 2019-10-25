FROM ruby:2.3.3
ENV RAILS_ROOT /myapp
RUN mkdir $RAILS_ROOT 
WORKDIR $RAILS_ROOT
COPY . $RAILS_ROOT
RUN bundle install
RUN bundle exec rake assets:precompile