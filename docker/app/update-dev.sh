#!/bin/sh
bundle exec rake db:migrate
bundle exec rake assets:precompile
echo "update-dev"
exec "$@"