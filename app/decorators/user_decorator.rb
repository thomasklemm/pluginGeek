class UserDecorator < Draper::Decorator
  delegate_all

  def name
    model[:name] || login
  end

  def email
    model[:email] || ""
  end

  def company
    model[:company] || ""
  end

  def location
    model[:location] || ""
  end

  def followers
    model[:followers] || 0
  end

  def github_url
    "https://github.com/#{ login }"
  end

  # Avatar defaults to default grey one
  def avatar_url
    model[:avatar_url] || "https://i2.wp.com/a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-user-420.png"
  end
end
