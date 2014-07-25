class User::Authentication < ActiveRecord::Base
  belongs_to :user

  validates :user,
    :provider,
    :uid,
    presence: true
end
