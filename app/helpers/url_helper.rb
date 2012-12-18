module UrlHelper
  # Construct language path
  def path(lang)
    "/#{ lang }"
  end

  # Mark matching paths as 'active'
  def current_path?(lang)
    (current_page?(path(lang)) || category_has_language?(lang) || repo_has_language?(lang)) ? 'active' : nil
  end

  def category_has_language?(lang)
    @category and @category.languages.include?(lang)
  end

  def repo_has_language?(lang)
    @repo and @repo.languages.include?(lang)
  end
end
