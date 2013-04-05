class CategoryDecorator < Draper::Decorator
  delegate_all

  decorates_association :repos
  decorates_association :similar_categories
  decorates_association :extended_links

  def description
    description = model.description.presence || ""
    h.word_wrap(description)
  end

  def stars
    stars = model.stars.presence || 0
    text = h.number_with_delimiter(stars)
    h.icon_tag(:star, text)
  end

  def score
    model.score.presence || 0
  end

  def repo_names
    list = model.repo_list
    (list.presence && list.split(", ")) || []
  end

  def popular_repo_names
    names = repo_names[0..1]
    (names.presence && names.join(", ")) || ""
  end

  def further_repo_names
    names = repo_names[2..100]
    (names.presence && names.join(", ")) || ""
  end

  #TODO: Specs
  def deep_link
    repo_names.size > 3 ? deep_link_with_count : deep_link_without_count
  end

  private

  def deep_link_with_count
    h.link_to " and #{ further_repo_names.count } more &raquo;".html_safe, self
  end

  def deep_link_without_count
    h.link_to " &raquo;".html_safe, self
  end
end
