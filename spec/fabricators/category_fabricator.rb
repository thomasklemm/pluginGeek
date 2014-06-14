Fabricator(:category) do
  name { sequence { |n| "Category #{n}"} }
  platforms { Array(Fabricate(:platform)) }
end
