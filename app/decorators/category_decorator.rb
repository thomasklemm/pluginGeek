class CategoryDecorator < Draper::Decorator
  delegate_all
  decorates_association :repos

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
    model[:knight_score] || 0
  end

  def knight_score
    score
  end

  def language_list
    language_names
  end

  def repo_names
    # NOTE: nil.to_s => ""
    model[:repo_names].to_s.split(', ') || []
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

  # All links including the ones from the repos associated with this category
  def sorted_links
    @sorted_links ||= begin
      l = (links.to_a | model.repos.includes(:links).flat_map(&:links).to_a).uniq
      l.sort_by(&:published_at).reverse
    end
  end
end
