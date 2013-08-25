class ServiceCategorization < ActiveRecord::Base
  belongs_to :service
  belongs_to :category

  validates :service, :category, presence: true
end
