class User < ActiveRecord::Base

  # Authenticates with sorcery!
  authenticates_with_sorcery! do |config|
    config.authetications_class = Authentication
  end

  # Mass-assignment protection
  attr_accessible :email, :password, :password_confirmation, :authentications_attributes

  # Validations
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

  # Authentications
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
end
