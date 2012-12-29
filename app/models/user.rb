# == Schema Information
# Schema version: 20121217114014
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  login                        :string(255)      not null
#  email                        :string(255)
#  name                         :string(255)
#  avatar_url                   :string(255)
#  github_url                   :string(255)
#  location                     :string(255)
#  company                      :string(255)
#  followers                    :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#
# Indexes
#
#  index_users_on_remember_me_token  (remember_me_token)
#

class User < ActiveRecord::Base
  ##
  # Modules
  #
  # Authenticates with sorcery!
  authenticates_with_sorcery! do |config|
    config.authetications_class = Authentication
  end

  ##
  # Relations & Validations
  #
  # Authentications
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  # Validations
  validates_uniqueness_of :username

  # Defaults
  def name
    self[:name] || login
  end

  ##
  # Mass-assignment protection
  #
  # REVIEW: does :username have to be whitelisted, try!
  attr_accessible :username, :authentications_attributes
end
