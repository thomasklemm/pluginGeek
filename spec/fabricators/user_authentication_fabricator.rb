Fabricator(:user_authentication, class_name: 'User::Authentication') do
  user
  provider "github"
  uid      "github_user_id"
end
