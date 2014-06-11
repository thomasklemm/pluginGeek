class RepoDecorator < Draper::Decorator
  delegate_all

  def description
    model.description.presence || 'Please add a description on Github.'
  end

  def github_updated_at
    (model.github_updated_at.presence || 36.months.ago).utc
  end

  def github_url
    "https://github.com/#{ owner_and_name }"
  end

  def homepage_url
    url = (model.homepage_url.presence || github_url)
    url.start_with?('http') ? url : "http://#{ url }"
  end

  def name
    model.owner_and_name.split('/')[1]
  end

  def owner
    model.owner_and_name.split('/')[0]
  end

  def parents_and_children
    @parents_and_children ||= (parents | children).uniq.sort_by(&:score).reverse
  end

  def stars
    h.number_with_delimiter(model.stars)
  end
end
