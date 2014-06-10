class CategoryDecorator < Draper::Decorator
  delegate_all

  def main_platform
    @main_platform ||= (platforms.first || Platform.all_platforms).decorate
  end

  def main_repo
    @main_repo ||= repos.first.andand.decorate
  end

  def stars
    h.number_with_delimiter(model.stars)
  end

  def description
    model.description.presence || 
    main_repo.andand.description.presence ||
    h.nbsp
  end

  def platform_names
    @platform_names ||= platforms.sort_by(&:position).map(&:name).join('/')
  end

  def sorted_repos
    @sorted_repos ||= repos.sort_by(&:score).reverse.map(&:decorate)
  end

  def repo_names
    @repo_owner_and_names ||= sorted_repos.map(&:name)
  end

  def repo_owner_and_names
    @repo_owner_and_names ||= sorted_repos.map(&:owner_and_name)
  end

  def short_formatted_repo_names
    if repo_names.size <= 3
      repo_names.to_sentence
    else
      [*repo_names.first(2), "#{ repo_names.size - 2 } more plugins..."].to_sentence
    end
  end

  def formatted_repo_names
    repo_names.to_sentence
  end

  def to_selectize_option
    {
      id: id,
      name: name,
      platform_names: platform_names,
      repos_count: repos_count,
      score: model.score,
      stars: model.stars,
      formatted_stars: stars,
      repo_names: formatted_repo_names,
      short_formatted_repo_names: short_formatted_repo_names
    }.to_json
  end
end
