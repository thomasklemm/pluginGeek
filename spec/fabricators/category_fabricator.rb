Fabricator(:category) do
  name { sequence { |n| "Category #{n}"} }
end
