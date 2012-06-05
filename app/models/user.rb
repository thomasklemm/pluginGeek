class User < ActiveRecord::Base

  # Authenticates with sorcery!
  authenticates_with_sorcery!

  # Mass-assignment protection
  attr_accessible :email, :password, :password_confirmation

  # Validations
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

end
