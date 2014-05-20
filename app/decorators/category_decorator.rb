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
end
