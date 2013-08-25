Fabricator(:category) do
  full_name { sequence(:full_name) { |n| "Category #{n}"} }
  slug { |attrs| attrs[:full_name].parameterize }
end
