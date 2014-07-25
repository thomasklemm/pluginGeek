Fabricator(:user_authentication) do
  user
  provider "github"
  uid      "github_user_id"
end
