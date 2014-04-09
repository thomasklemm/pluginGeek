class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :description, length: {maximum: 360} # Review: Should be more concise?

  scope :order_by_name,  -> { order(name: :asc) }
  scope :order_by_score, -> { order(score: :desc) }

  # scope :ids_and_names, -> { select([:id, :name]).order_by_score }
  # scope :ids_and_names_without, ->(category) { ids_and_names.where.not(id: category.id) }

  def self.for_platform(platform_slug)
    if platform_slug.present?
      platform = Platform.find_by(slug: platform_slug)
      platform.categories
    else
      Category
    end
  end

  has_many :platforms,
    -> { order_by_position },
    through: :platform_categories
  has_many :platform_categories,
    dependent: :destroy

  def main_platform
    platforms.first
  end

  has_many :repos,
    -> { order_by_score },
    through: :categorizations
  has_many :categorizations,
    dependent: :destroy

  has_many :links,
    through: :link_relationships
  has_many :link_relationships,
    as: :linkable,
    dependent: :destroy

  # Links associated with either the category or one of its referenced repos
  def extended_links
    @extended_links ||= (links | links_of_repos).
      uniq.
      sort_by(&:published_at).
      reverse
  end

  # Review: There might be a nicer query?
  def links_of_repos
    @links_of_repos ||= repos.
      includes(:links).
      flat_map(&:links)
  end

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

  def similar_categories
    @similar_categories ||= (related_categories | reverse_related_categories).
      uniq.
      sort_by(&:stars).
      reverse
  end

  has_many :services,
    through: :service_categorizations
  has_many :service_categorizations,
    dependent: :destroy

  before_save :assign_counters

  def stars
    self[:stars] || 0
  end

  def score
    self[:score] || 0
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  private

  def assign_counters
    self.stars = repos.map(&:stars).reduce(:+) rescue 0 || 0
    self.score = repos.map(&:score).reduce(:+) rescue 0 || 0
  end
end
