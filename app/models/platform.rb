class Platform < ActiveRecord::Base
  validates :name,
    :slug,
    :position,
    presence: true

  has_many :categories,
    -> { order_by_name },
    through: :platform_categories
  has_many :platform_categories,
    dependent: :destroy

  scope :order_by_position, -> { order(position: :asc) }

  def to_param
    slug
  end
end
