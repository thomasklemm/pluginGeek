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

  scope :default, -> { where(default: true).first }
  def self.default_slug
    default.try(:slug).presence || :ruby
  rescue
    # When the platforms relation doesn't exist in the database,
    # the app would not start up as Platform.default_slug is used
    # in config/routes.rb
    :ruby
  end

  def to_param
    slug
  end
end
