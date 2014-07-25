class Service < ActiveRecord::Base
  validates :name,
    :display_url,
    :target_url,
    :description,
    presence: true

  has_many :categories,
    through: :service_categorizations
  has_many :service_categorizations,
    class_name: 'Service::Categorization',
    dependent: :destroy

  scope :for_category, ->(category) { category.services }

  def self.random(count = 1)
    ids = pluck(:id).sample(count)
    where(id: ids)
  end
end
