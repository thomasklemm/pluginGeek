class CategoryDecorator < Draper::Decorator
  delegate_all

  def description
    description = model.description.presence || repos.first.try(:description).presence || ''
    h.word_wrap(description, line_width: 100)
  end

  def stars
    h.icon_tag(:star, h.number_with_delimiter(model.stars))
  end

  def repo_links
    links = repos.limit(3).map { |repo| h.link_to repo.owner_and_name, repo }
    links.try(:to_sentence).try(:html_safe)
  end
end
