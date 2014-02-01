class User < ActiveRecord::Base
  devise :rememberable,
    :trackable,
    :omniauthable

  validates :login,
    presence: true,
      uniqueness: true

  # Authentication through Github
  has_many :authentications, dependent: :destroy

  alias_attribute :staff_member, :staff

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
end
