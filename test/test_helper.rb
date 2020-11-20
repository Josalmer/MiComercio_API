ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  ENV['RAILS_ENV'] ||= 'test'

  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/controllers/api/v1/passwords_controller.rb'
  add_filter 'app/controllers/application_controller.rb'
end

require_relative 'helpers/authorization_helper'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include AuthorizationHelper
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors) 

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def json_response
    JSON.parse(response.body)
  end
end
