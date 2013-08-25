Fabricator(:link_relationship) do
  link
  linkable { [Fabricate(:repo), Fabricate(:category)].sample }
end
