class Authentication < ActiveRecord::Base
  belongs_to :user
  validates :user,

  validates :provider,
            :uid,
            presence: true
end
