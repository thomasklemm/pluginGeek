class CategoryDecorator < Draper::Decorator
  delegate_all


  # Autocomplete category full_names on repo#edit
  def self.full_names_for_autocomplete
    order_by_score.pluck(:full_name).to_json
  end

  ##
  # Getters and defaults
  def description
    self[:description] || ''
  end

  def description_with_fallback
    description.present? ? description : '<em>Please add a description to this category.</em>'
  end

  def stars
    self[:stars] || 0
  end

  def knight_score
    self[:knight_score] || 0
  end


  def popular_repos
    repos[0..2].to_a.map(&:name).join(', ') || ''
  end

  # nil.to_a => []
  def further_repos
    repos[3..1000].to_a.map(&:name).join(', ') || ''
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
    l = (links.to_a | repos.joins(:links).includes(:links).flat_map(&:links).to_a).uniq
    l.sort_by(&:published_at).reverse
  end

  def language_list
    @languages ||= plain_language_list
  end

  # Sublanguages important internally for searching et al.,
  # but externally only the main languages should be displayed when assigned
  def plain_language_list
    langs = languages.map(&:name)
    langs.include? 'Web'    and langs.delete_if {|lang| Language::Web.include?(lang.downcase)}
    langs.include? 'Mobile' and langs.delete_if {|lang| Language::Mobile.include?(lang.downcase)}
    langs.join(', ')
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
