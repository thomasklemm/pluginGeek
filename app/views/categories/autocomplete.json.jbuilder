@categories = @categories.decorate

json.categories @categories do |category|
  json.(category, :id, :name, :platform_names, :repos_count)
  json.(category.model, :stars, :score)
  json.formatted_stars category.stars
  json.repo_names category.formatted_repo_names
  json.short_formatted_repo_names category.short_formatted_repo_names
end
