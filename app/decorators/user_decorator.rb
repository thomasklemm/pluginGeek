class UserDecorator < Draper::Decorator
  delegate_all

  # Grey Github octocat
  DEFAULT_AVATAR_URL =
    'https://i2.wp.com/a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-user-420.png'

  def name
    model.name.presence || login
  end

  def email
    model.email.presence || ''
  end

  def company
    model.company.presence || ''
  end

  def location
    model.location.presence || ''
  end

  def followers
    model.followers.presence || 0
  end

  def avatar_url
    model.avatar_url.presence || DEFAULT_AVATAR_URL
  end

  def github_url
    "https://github.com/#{ login }"
  end
end
