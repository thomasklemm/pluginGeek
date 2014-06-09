@categories = @categories.decorate

json.categories @categories do |category|
  json.(category, :id, :name, :platform_names, :repo_names, :repos_count)
  json.(category.model, :stars, :score)
end
