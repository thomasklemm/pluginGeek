class UserDecorator < Draper::Decorator
  delegate_all

  # Defaults and virtual attributes
  def name
    self[:name] || login
  end

  def github_url
    "https://github.com/#{ login }"
  end

  # default grey github avatar
  def avatar_url
    self[:avatar_url] || 'https://i2.wp.com/a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-user-420.png'
  end

  def email;      self[:email] || ''     ; end
  def company;    self[:company] || ''   ; end
  def location;   self[:location] || ''  ; end
  def followers;  self[:followers] || 0  ; end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
