class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :description, length: {maximum: 360} # Review: Should be more concise?

  scope :for_picker, -> { includes(:platforms, :repos).order_by_score  }
  scope :order_by_name,  -> { order(name: :asc) }
  scope :order_by_score, -> { order(score: :desc) }

  has_many :platforms,
    -> { order_by_position },
    through: :platform_categories
  has_many :platform_categories,
    dependent: :destroy

  has_many :repos,
    through: :categorizations
  has_many :categorizations,
    dependent: :destroy

  has_many :related_categories,
    through: :category_relationships,
    source: :category
  has_many :category_relationships,
    foreign_key: :other_category_id,
    dependent: :destroy

  has_many :reverse_related_categories,
    through: :reverse_category_relationships,
    source: :other_category
  has_many :reverse_category_relationships,
    class_name: 'CategoryRelationship',
    foreign_key: :category_id,
    dependent: :destroy

  has_many :links,
    through: :link_relationships
  has_many :link_relationships,
    as: :linkable,
    dependent: :destroy

  has_many :services,
    through: :service_categorizations
  has_many :service_categorizations,
    dependent: :destroy

  before_save :assign_counters

  def assignable_related_categories
    Category.for_picker.without(self)
  end

  def extended_links
    @extended_links ||= (links | links_of_repos).uniq
  end

  def links_of_repos
    @links_of_repos ||= repos.includes(:links).flat_map(&:links)
  end

  def score
    self[:score] || 0
  end

  def similar_categories
    @similar_categories ||= (related_categories | reverse_related_categories).uniq.sort_by(&:stars).reverse
  end

  def slug
    @slug ||= generate_slug
  end

  def stars
    self[:stars] || 0
  end

  def to_param
    slug
  end

  private

  def assign_counters
    self.stars = repos.map(&:stars).reduce(:+) rescue 0 || 0
    self.score = repos.map(&:score).reduce(:+) rescue 0 || 0
  end

  def generate_slug
    elements = []
    elements += [id, name.parameterize]
    elements += platforms.map { |platform| platform.name.parameterize } if platforms.any?
    elements.join('-')
  end
end
