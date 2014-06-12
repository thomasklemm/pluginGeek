Fabricator(:category) do
  name { sequence { |n| "Category #{n}"} }
  platforms { [Fabricate(:platform)] }
end
