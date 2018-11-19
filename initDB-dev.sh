#!/bin/sh
bundle exec rake RAILS_ENV=development db:reset
echo "initDB-dev"
exec "$@"