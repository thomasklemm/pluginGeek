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
    @platform_names ||= platforms.sort_by(&:position).map(&:name)
  end

  def formatted_platform_names
    platform_names.join(' & ')
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

  def formatted_repo_names(options = {})
    count = 3
    shorten = options.fetch :shorten, false

    if shorten && repo_names.size > (count + 1)
      [*repo_names.first(count), "#{repo_names.size - count} more plugins..."].to_sentence
    else
      repo_names.to_sentence
    end
  end

  def to_selectize_option
    {
      id: id,
      name: name,
      repos_count: repos_count,
      score: model.score,
      stars: model.stars,
      formatted_stars: stars,
      formatted_platform_names: formatted_platform_names,
      formatted_repo_names: formatted_repo_names,
      short_repo_names: formatted_repo_names(shorten: true)
    }.to_json
  end
end
