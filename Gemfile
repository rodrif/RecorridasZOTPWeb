source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.0.3.4'

gem 'jquery-turbolinks'
gem 'whenever', :require => false
gem 'bcrypt'
gem 'will_paginate-bootstrap'
gem 'jquery-ui-rails'
gem 'will_paginate'
gem 'filterrific', '>= 2.1.2', git: 'https://github.com/ayaman/filterrific.git'
gem 'bootstrap-sass'
gem 'devise'
gem 'devise_token_auth'
gem 'google-analytics-rails'
gem 'zip-zip' # will load compatibility for old rubyzip API.
gem 'geocoder'
gem 'exception_notification'
gem "simple_calendar"
gem 'mysql2'
gem 'rubyzip'
gem 'axlsx'
gem 'caxlsx_rails'
gem 'caracal-rails'
gem 'delayed_job'
gem 'google-api-client', '~> 0.34'
gem 'materialize-sass', '~> 1.0.0'
gem 'material_icons'
gem 'will_paginate-materialize', git: 'https://github.com/mldoscar/will_paginate-materialize', branch: 'master'
gem 'fullcalendar-rails'
gem 'momentjs-rails'

# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '>= 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'bullet'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'capybara', '~> 2.15.1'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # gem 'therubyracer'
  gem 'puma'

  gem 'rubocop', '~> 1.5', require: false # Static code analizer
  gem 'rubycritic', require: false # Checks for code optimization
  gem 'rails_best_practices' # Checks for code optimization
  gem 'traceroute' # Checks for undefined routes and unreachable actions.
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :test do
  gem 'capybara-email'
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end