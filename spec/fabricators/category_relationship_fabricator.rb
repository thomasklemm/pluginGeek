Fabricator(:category_relationship) do
  category
  other_category { Fabricate(:category) }
end
