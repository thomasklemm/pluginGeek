class Platform < ActiveRecord::Base
  validates :name,
    :slug,
    :position,
    presence: true

  has_many :categories,
    -> { order_by_name },
    through: :platform_categories
  has_many :platform_categories

  scope :order_by_position, -> { order(position: :asc) }

  scope :default, -> { where(default: true).first }
  def self.default_slug
    default.try(:slug).presence || :ruby
  end

  def to_param
    slug
  end
end
