class CategoryDecorator < Draper::Decorator
  delegate_all

  # Attributes
  def description
    model.description.presence ||
      main_repo.andand.description.presence ||
      h.nbsp
  end

  def stars
    h.number_with_delimiter(model.stars)
  end

  # Platforms
  def platform_names
    @platform_names ||= platforms.map(&:name)
  end

  def formatted_platform_names
    platform_names.to_sentence
  end

  # Main platform
  def main_platform
    return unless platform_ids.present?
    @main_platform ||= Platform.find(platform_ids.first).decorate
  end

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
  # Links

  def links
    @links ||= (model.links | links_of_repos).uniq
  end

  ##
  # Related categories

  def related_categories
    @related_categories ||= (model.related_categories | reverse_related_categories).uniq.sort_by(&:stars).reverse
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

  private

  def links_of_repos
    @links_of_repos ||= model.repos.includes(:links).flat_map(&:links)
  end
end
