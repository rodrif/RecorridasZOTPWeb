#!/bin/sh
bundle exec rake RAILS_ENV=development db:migrate
echo "update-dev"
exec "$@"