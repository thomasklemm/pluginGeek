# == Schema Information
#
# Table name: users
#
#  avatar_url :text
#  company    :text
#  created_at :datetime         not null
#  email      :text
#  followers  :integer
#  id         :integer          not null, primary key
#  location   :text
#  login      :text             not null
#  name       :text
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base

  ##
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
end
