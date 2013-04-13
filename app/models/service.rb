# == Schema Information
#
# Table name: services
#
#  created_at  :datetime         not null
#  description :text
#  display_url :text
#  id          :integer          not null, primary key
#  name        :text
#  target_url  :text
#  updated_at  :datetime         not null
#

class Service < ActiveRecord::Base
  # Validations
  validates :name, :display_url, :target_url, :description, presence: true

  # Categories
  has_many :service_categorizations,
    dependent: :destroy
  has_many :categories,
    through: :service_categorizations

  # Retrieve a number of services in random order
  def self.random(count=1)
    ids = pluck(:id).sample(count)
    where(id: ids).shuffle
  end

  # Fetch and shuffle the services associated with a category
  def self.for_category(category)
    category.services.shuffle || []
  end
end
