Fabricator(:repo) do
  full_name { sequence(:full_name) { |n| "owner#{ n }/repo#{ n }" } }
end
