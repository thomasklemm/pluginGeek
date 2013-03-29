class CategoryDecorator < Draper::Decorator
  delegate_all
  decorates_association :repos
  decorates_association :extended_links

  def description
    model[:description] || ""
  end

  def description_with_fallback
    description.present? ? description : '<em>Please add a description to this category.</em>'
  end

  def stars
    model[:stars] || 0
  end

  def score
    model[:score] || 0
  end

  def language_list
    language_names
  end

  def repo_names
    # NOTE: nil.to_s => "", "".split(', ') => []
    model[:repo_names].to_s.split(', ')
  end

  def popular_repos
    repo_names[0..1].to_a.join(', ') || ""
  end

  def further_repos
    # NOTE: nil.to_a => []
    repo_names[2..1000].to_a.join(', ') || ""
  end

  def name
    @name ||= begin
      match = full_name.match %r{(?<name>.*)[[:space:]]\(}
      match.present? ? match[:name].strip : full_name
    end
  end

  def extended_links
    @extended_links ||= (links | links_of_repos).uniq.sort_by(&:published_at).reverse
  end

  def links_of_repos
    # call on model required for direct call instead of call on decorator
    model.repos.includes(:links).flat_map(&:links)
  end
end
