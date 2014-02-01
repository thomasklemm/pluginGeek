class RepoDecorator < Draper::Decorator
  delegate_all

  decorates_association :categories
  decorates_association :parents_and_children

  def owner
    model.owner.presence || full_name.split('/')[0]
  end

  def name
    model.name.presence || full_name.split('/')[1]
  end

  def stars
    text = h.number_with_delimiter(model.stars)
    h.icon_tag(:star, text)
  end

  def description
    model.description.presence || default_description
  end

  def default_description
    "<em>Please add a description on Github.</em>".html_safe
  end

  # Returns either homepage url as an absolute path if only a relative one is given
  # or the github_url
  def homepage_url
    url = model.homepage_url

    url.present? or return github_url
    url.start_with?('http') ? url : "http://#{ url }"
  end

  def github_url
    "https://github.com/#{ full_name }"
  end

  # jQuery timeago compatible timestamp
  def timestamp
    github_updated_at.iso8601
  end

  def written_timestamp
    github_updated_at.to_s(:long)
  end

  # CSS classes marking activity
  def activity_class
    if last_updated < 4.months
      'high'
    elsif last_updated < 12.months
      'medium'
    else
      'low'
    end
  end
end
