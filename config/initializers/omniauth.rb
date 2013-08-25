# Logging
OmniAuth.config.logger = Rails.logger

# Enable OmniAuth test mode
Rails.env.test? and OmniAuth.config.test_mode = true

# Add a mock for authentication with Github
# Will be loaded before each example in spec/support/omniauth.rb.
# OmniAuth.config.mock_auth[:github] =
#   YAML.load(File.read(Rails.root.join("spec", "support", "omniauth", "github.yml")))
