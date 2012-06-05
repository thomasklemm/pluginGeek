class User < ActiveRecord::Base

  # Authenticates with sorcery!
  authenticates_with_sorcery! do |config|
    config.authetications_class = Authentication
  end

  # Mass-assignment protection
  #   REVIEW: does :username have to be whitelisted, try!
  attr_accessible :username, :authentications_attributes

  # Validations
  validates_uniqueness_of :username

  # Authentications
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
end
