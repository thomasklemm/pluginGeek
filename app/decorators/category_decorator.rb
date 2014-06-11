class CategoryDecorator < Draper::Decorator
  delegate_all

  ##
  # Attributes

  def description
    model.description.presence ||
      main_repo.description.presence if main_repo ||
      h.nbsp
  end

  def stars
    h.number_with_delimiter(model.stars)
  end

  ##
  # Platforms

  def main_platform
    @main_platform ||= begin
      platform = platforms.sort_by(&:position).first || Platform.all_platforms
      platform.decorate
    end
  end

  def platform_names
    @platform_names ||= begin
      platforms.sort_by(&:position).map(&:name)
    end
  end

  def formatted_platform_names
    platform_names.join(' & ')
  end

  ##
  # Repos

  def repos
    @repos ||= model.repos.sort_by(&:score).reverse.map(&:decorate)
  end

  def main_repo
    @main_repo ||= begin
      repo = model.repos.order_by_score.first
      repo.decorate if repo
    end
  end

  def repo_names
    @repo_names ||= repos.map(&:name)
  end

  def formatted_repo_names(options = {})
    count = 3
    shorten = options.fetch :shorten, false

    if shorten && repo_names.size > (count + 1)
      [*repo_names.first(count), "#{repo_names.size - count} more plugins..."].to_sentence
    else
      repo_names.join(', ')
    end
  end

  ##
  # Selectize option

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
