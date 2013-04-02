# Enable OmniAuth test mode
Rails.env.test? and OmniAuth.config.test_mode = true

# Add a mock for authentication with Github
OmniAuth.config.mock_auth[:github] = YAML.load(File.read(Rails.root.join("spec", "support", "omniauth", "github.yml")))

# Logging
OmniAuth.config.logger = Rails.logger
