VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.hook_into :webmock
  c.filter_sensitive_data('<GITHUB_API_KEY>')    { ENV['GITHUB_API_KEY'] }
  c.filter_sensitive_data('<GITHUB_API_SECRET>') { ENV['GITHUB_API_SECRET'] }
end
