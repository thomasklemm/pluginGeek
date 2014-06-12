Fabricator(:link) do
  url          { sequence(:url) { |n| "url_#{ n }" } }
  title        "link title"
  submitter    { Fabricate(:user) }
end
