class RepoDecorator < Draper::Decorator
  delegate_all

  # FIXME: Fix the RepoDecorator

  def owner
    self[:owner].present? ? self[:owner] : full_name.split('/')[0]
  end

  def name
    self[:name].present? ? self[:name] : full_name.split('/')[1]
  end

  def github_url
    "https://github.com/#{full_name}"
  end

  def homepage_url
    self[:homepage_url].present? ? self[:homepage_url] : github_url
  end

  def github_description
    self[:github_description].present? ? self[:github_description] : ''
  end

  def description
    self[:description].present? ? self[:description] : github_description
  end

  def github_updated_at
    self[:github_updated_at].present? ? self[:github_updated_at].utc : 2.years.ago.utc
  end

  def timestamp
    github_updated_at.utc # jQuery timeago input format
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
