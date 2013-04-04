RSpec.configure do |config|
  config.before(:each) do
    OmniAuth.config.mock_auth[:github] =
      YAML.load(File.read(Rails.root.join("spec", "support", "omniauth", "github.yml")))
  end
end
