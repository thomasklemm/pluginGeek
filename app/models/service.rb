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
end
