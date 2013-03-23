Fabricator(:user) do
  login { sequence(:login) { |n| "github_user_#{ n }" } }
end
