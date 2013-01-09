# == Schema Information
#
# Table name: users
#
#  admin               :boolean          default(FALSE)
#  avatar_url          :text
#  company             :text
#  created_at          :datetime         not null
#  current_sign_in_at  :datetime
#  current_sign_in_ip  :string(255)
#  email               :text
#  followers           :integer
#  id                  :integer          not null, primary key
#  last_sign_in_at     :datetime
#  last_sign_in_ip     :string(255)
#  location            :text
#  login               :text             not null
#  name                :text
#  remember_created_at :datetime
#  remember_token      :text
#  sign_in_count       :integer          default(0)
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_login           (login) UNIQUE
#  index_users_on_remember_token  (remember_token)
#

class User < ActiveRecord::Base
  # Selected Devise modules
  devise :rememberable, :trackable, :omniauthable

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

  ##
  # Authentication through Github
  has_many :authentications, dependent: :destroy

  # Find or create user from Github omniauth
  def self.find_or_create_user_from_github(omniauth)
    authentication = Authentication.find_by_provider_and_uid(omniauth.provider, omniauth.uid)

    # See is user can be found through an existing authentication,
    # return the user instance if there is a match
    if authentication && authentication.user
      user = authentication.user

      # Update user attributes
      user.map_user_attributes(omniauth)
      user.save

      # And quit returning user instance
      return user
    end

    # Create user if first login
    user = User.create! do |u|
      u.map_user_attributes(omniauth)
    end

    # Create authentication
    user.create_authentication(omniauth)

    # Return user
    user.save
    user
  end

  # Set user attributes from omniauth hash
  def map_user_attributes(omniauth)
    info = omniauth.info
    raw_info = omniauth.extra.raw_info

    self.login = info.nickname
    self.name  = info.name  || ''
    self.email = info.email || ''
    self.avatar_url = info.image || ''

    self.company  = raw_info.company
    self.location = raw_info.location
    self.followers = raw_info.followers
    self # return self
  end

  # Create authentication from omniauth hash
  def create_authentication(omniauth)
    authentications.create! do |a|
      a.provider = omniauth.provider
      a.uid = omniauth.uid
    end
  end

  attr_accessible :login, :name, :email, :company, :location, :followers, :avatar_url, :remember_me
end
