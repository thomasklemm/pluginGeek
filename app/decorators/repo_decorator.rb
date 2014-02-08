class RepoDecorator < Draper::Decorator
  delegate_all

  def owner
    model.owner_and_name.split('/')[0]
  end

  def name
    model.owner_and_name.split('/')[1]
  end

  def description
    model.description.presence || 'Please add a description on Github.'
  end

  def stars
    h.number_with_delimiter(model.stars)
  end

  def github_url
    "https://github.com/#{ owner_and_name }"
  end

  def homepage_url
    url = (model.homepage_url.presence || github_url)
    url.start_with?('http') ? url : "http://#{ url }"
  end

  def github_updated_at
    (model.github_updated_at || 2.years.ago).utc
  end

  # jQuery timeago format
  def timestamp
    github_updated_at.iso8601
  end

  def written_timestamp
    github_updated_at.to_s(:long)
  end

  def activity_class
    case
    when github_updated_at > 4.months.ago  then 'high'
    when github_updated_at > 12.months.ago then 'medium'
    else                                        'low'
    end
  end
end
