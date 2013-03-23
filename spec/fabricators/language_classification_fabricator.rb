Fabricator(:language_classification) do
  language
  classifier { Fabricate(:category) }
end
