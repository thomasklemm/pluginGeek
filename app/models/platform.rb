class Platform < ActiveRecord::Base
  validates :name,
    :slug,
    :position,
    presence: true

  has_many :categories,
    -> { order_by_name },
    through: :platform_categories
  has_many :platform_categories

  scope :default, -> { where(default: true).first }
  def self.default_id
    default.try(:id).presence || 1
  end
end
