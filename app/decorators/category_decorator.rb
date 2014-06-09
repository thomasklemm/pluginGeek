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
    platforms.order_by_position.map(&:name).to_sentence
  end

  def repo_names
    names = repos.order_by_score.map(&:owner_and_name)
    repo_names = names.shift(2).join(', ')
    repo_names << " and #{ names.size } more..." if names.size >= 1
    repo_names
  end
end
