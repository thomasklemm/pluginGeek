class CategoryDecorator < Draper::Decorator
  delegate_all

  def description
    h.word_wrap(model.description.presence || '')
  end

  def stars
    h.icon_tag(:star, h.number_with_delimiter(model.stars))
  end

  def popular_repo_names
    repo_names(0..1)
  end

  def further_repo_names
    repo_names(2..99)
  end

  private

  def repo_names(range)
    names = repos.map(&:owner_and_name)[range]
    names && names.join(', ')
  end
end
