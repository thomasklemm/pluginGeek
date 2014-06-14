Fabricator(:platform) do
  name      { sequence(:name) { |i| "Platform #{i}" } }
  slug      { sequence(:slug) { |i| "platform_#{i}" } }
  position  { sequence(:position) }
end
