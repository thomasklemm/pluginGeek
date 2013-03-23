Fabricator(:repo_relationship) do
  parent { Fabricate(:repo) }
  child { Fabricate(:repo) }
end
