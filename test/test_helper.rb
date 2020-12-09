require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # for debug problems
    #fixtures :alert_types, :familias, :people, :ranchadas, :alerts, :areas, :zones

    # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
    include Devise::TestHelpers
end
