ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'capybara/rails'
require 'active_support/testing/setup_and_teardown'
require 'turn'

# require 'miniskirt'
# require 'mocha'

# Support files
Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each do |file|
  require file
end

class MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown

  alias :method_name :__name__ if defined? :__name__
end

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  register_spec_type(/integration$/, self)
end

class HelperTest < MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior
  register_spec_type(/Helper$/, self)
end

Turn.config do |c|
  # use one of output formats:
  # :outline  - turn's original case/test outline mode [default]
  # :progress - indicates progress with progress bar
  # :dotted   - test/unit's traditional dot-progress mode
  # :pretty   - new pretty reporter
  # :marshal  - dump output as YAML (normal run mode only)
  # :cue      - interactive testing
  c.format  = :outline
  # turn on invoke/execute tracing, enable full backtrace
  c.trace   = true
  # use humanized test names (works only with :outline format)
  c.natural = true
end

# Source:
# 1) Railscasts #327: http://railscasts.com/episodes/327-minitest-with-rails
# 2) http://stackoverflow.com/questions/7628654/using-minitest-in-rails#comment12068363_9221625
