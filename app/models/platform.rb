class Platform < ActiveRecord::Base

  validates :name, :position, presence: true
  validates :slug, presence: true, uniqueness: true

  has_many :categories,
    -> { order_by_name },
    through: :platform_categories
  has_many :platform_categories,
    dependent: :destroy

  scope :for_picker, -> { order_by_position }
  scope :order_by_position, -> { order(position: :asc) }

  def self.find_by_slug(slug)
    find_by(slug: slug.underscore) if slug.present?
  end

  def self.find_by_slug!(slug)
    find_by_slug(slug) or raise ActiveRecord::RecordNotFound
  end

  def self.for_navigation
    [all_platforms, self.order_by_position.to_a].flatten
  end

  def self.all_platforms
    Platform.new(id: 0, slug: 'all_platforms', name: 'All platforms', position: 0)
  end

  # Defines class level finders
  # to retrieve each platform by its slug
  all.each do |platform|
    define_singleton_method platform.slug do
      find_by_slug!(platform.slug)
    end
  end

  def self.current(slug = nil)
    find_by_slug(slug) || all_platforms
  end

  def categories
    all_platforms? ? Category.order_by_name : super
  end

  def categories_count
    all_platforms? ? Category.count : super
  end

  def to_param
    slug.parameterize
  end

  private

  def all_platforms?
    slug == 'all_platforms'
  end

  def create_or_update
    # Don't persist the 'all_platforms' platform
    return true if all_platforms?
    super
  end

end
