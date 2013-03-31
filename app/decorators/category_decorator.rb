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

  def extended_links
    @extended_links ||= extended_links!
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

  private

  def extended_links!
    l = (links | links_of_repos).uniq
    l.sort_by(&:published_at).reverse
  end

  def links_of_repos
    # call on model required for direct call instead of call on decorator
    model.repos.includes(:links).flat_map(&:links)
  end
end
