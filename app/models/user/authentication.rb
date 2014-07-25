class User::Authentication < ActiveRecord::Base
  self.table_name = 'authentications'

  belongs_to :user

  validates :user,
    :provider,
    :uid,
    presence: true
end
