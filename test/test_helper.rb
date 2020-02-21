ENV['RAILS_ENV'] ||= 'test'
# Used for Capybara chrome to be in the correct timezone.
ENV['TZ'] ||= 'Europe/Zurich'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    # There's an organization with the handle "peter".
    host! 'peter.example.com'
    sign_in users(:peter)
  end
end
