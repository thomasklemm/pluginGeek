Fabricator(:repo) do
  owner_and_name { sequence { |n| "repo_owner/repo_name_#{ n }" } }
end
