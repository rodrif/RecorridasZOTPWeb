#!/bin/sh
bundle exec rake db:reset
echo "initDB-dev"
exec "$@"