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
    model[:repo_names].to_s.split(', ') || []
  end

  def popular_repos
    repo_names[0..1].to_a.join(', ') || ""
  end

  # nil.to_a => []
  def further_repos
    repo_names[2..1000].to_a.join(', ') || ""
  end

  def name
    @name ||= begin
      match = full_name.match %r{(?<name>.*)[[:space:]]\(}
      match.present? ? match[:name].strip : full_name
    end
  end

  # All links including the ones from the repos associated with this category
  # nil.to_a => []
  def deep_links
    # REVIEW: This results in two ugly queries
    l = (links.to_a | model.repos.joins(:links).includes(:links).flat_map(&:links).to_a).uniq
    l.sort_by(&:published_at).reverse
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
