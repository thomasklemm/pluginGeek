class CategoryDecorator < Draper::Decorator
  delegate_all

  decorates_association :repos
  decorates_association :similar_categories
  decorates_association :extended_links

  def description
    model[:description].presence || ""
  end

  def stars
    model[:stars].presence || 0
  end

  def score
    model[:score].presence || 0
  end

  def repo_names
    list = model[:repo_list]
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
end
