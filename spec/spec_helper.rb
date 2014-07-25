ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'
require 'webmock/rspec'
require 'capybara/rails'

# Requires namespaced models and controllers
Dir[Rails.root.join("app/controllers/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("app/models/**/*.rb")].each {|f| require f}

# Requires lib directory
Dir[Rails.root.join("lib/**/*.rb")].each {|f| require f}

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

module Features
  # Extend this module in spec/support/features/*.rb
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Rails.application.routes.url_helpers
  config.include Features, type: :feature
  config.include Formulaic::Dsl, type: :feature

  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.use_transactional_fixtures = false

  # Devise test helpers in controllers
  config.include Devise::TestHelpers, type: :controller
end

ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :webkit
WebMock.disable_net_connect!(allow_localhost: true)
