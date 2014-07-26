RSpec.configure do |config|
  config.before(:each) do
    auth_file_path = Rails.root.join('spec/support/omniauth', 'github.yml')
    github_auth = YAML.load(File.read(auth_file_path))
    OmniAuth.config.mock_auth[:github] = github_auth
  end
end
