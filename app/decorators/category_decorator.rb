class CategoryDecorator < Draper::Decorator
  delegate_all
  decorates_associations :platforms, :repos, :similar_categories, :links, :extended_links

  def description
    description = model.description.presence || model.repos[0].try(:description).presence || ''
    h.word_wrap(description, line_width: 100)
  end

  def stars
    h.number_with_delimiter(model.stars)
  end

  def repo_links
    links = model.repos[0..2].map { |repo| h.link_to repo.owner_and_name, repo }
    links.try(:to_sentence).try(:html_safe)
  end
end
