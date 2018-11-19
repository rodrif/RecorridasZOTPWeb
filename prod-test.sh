#!/bin/sh
bundle exec rake RAILS_ENV=production db:reset
exec "$@"