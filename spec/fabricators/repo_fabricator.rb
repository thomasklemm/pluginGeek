Fabricator(:repo) do
  owner { sequence(:owner) { |n| "repo_owner_#{ n }" } }
  name  { sequence(:name)  { |n| "repo_name_#{ n }" } }
  full_name { |attrs| "#{ attrs[:owner] }/#{ attrs[:name] }" }
end
