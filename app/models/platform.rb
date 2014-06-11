class Platform < ActiveRecord::Base

  # Platform::SLUGS returns an array of all the slugs of our platforms
  #  Example: ['all_platforms', 'ruby', 'javascript', 'html_css']
  SLUGS = order(position: :asc).pluck(:slug)

  validates :name, :position, presence: true
  validates :slug, presence: true, uniqueness: true

  has_many :categories,
    -> { order_by_name },
    through: :platform_categories
  has_many :platform_categories,
    dependent: :destroy

  scope :order_by_position, -> { order(position: :asc) }

  def self.find_by_slug(slug)
    find_by(slug: slug.underscore) if slug.present?
  end

  def self.find_by_slug!(slug)
    find_by_slug(slug) or raise ActiveRecord::RecordNotFound
  end

  # Defines class level finders
  # to retrieve each platform by its slug
  SLUGS.each do |slug|
    define_singleton_method slug do
      find_by_slug!(slug)
    end
  end

  def self.current(slug = nil)
    find_by_slug(slug) || all_platforms
  end

  def categories
    all_platforms? ? Category.order_by_name : super
  end

  def all_platforms?
    slug == 'all_platforms'
  end

  def to_param
    slug.parameterize
  end

end
