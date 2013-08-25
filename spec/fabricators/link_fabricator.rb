Fabricator(:link) do
  url            { sequence(:url) { |n| "url_#{ n }" } }
  title          "link title"
  published_at   Date.current

  submitter      { Fabricate(:user) }
end
