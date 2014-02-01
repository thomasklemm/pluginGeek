class Category < ActiveRecord::Base
  # Validations
  validates :full_name, presence: true
  validates :description, length: {maximum: 360}

  # Named scopes
  def self.order_by_score
    order('categories.score DESC')
  end

  def self.order_by_name
    order('categories.full_name ASC')
  end

  def self.ids_and_full_names
    select([:id, :full_name]).
      order_by_score
  end

  def self.ids_and_full_names_without(repo)
    where.not(id: repo.id).
      ids_and_full_names
  end

  # Retrieve a number of featured repos in random order
  def self.featured(count=1)
    where(featured: true).sample(count).shuffle
  end

  # Repos
  has_many :categorizations,
    dependent: :destroy
  has_many :repos,
    -> { order(score: :desc) },
    through: :categorizations

  # Languages
  has_many :language_classifications,
    as: :classifier,
    dependent: :destroy
  has_many :languages,
    through: :language_classifications

  # Links
  has_many :link_relationships,
    as: :linkable,
    dependent: :destroy
  has_many :links,
    -> { uniq },
    through: :link_relationships

  # Related categories
  has_many :category_relationships,
    foreign_key: :other_category_id,
    dependent: :destroy

  has_many :reverse_category_relationships,
    class_name: 'CategoryRelationship',
    foreign_key: :category_id,
    dependent: :destroy

  has_many :related_categories,
    through: :category_relationships,
    source: :category

  has_many :reverse_related_categories,
    through: :reverse_category_relationships,
    source: :other_category

  # Services
  has_many :service_categorizations,
    dependent: :destroy
  has_many :services,
    through: :service_categorizations

  # Callbacks
  before_save :assign_stars
  before_save :assign_score
  before_save :assign_repos_count

  # Defaults
  def stars
    self[:stars] || 0
  end

  def score
    self[:score] || 0
  end

  def name
    match = full_name.match %r{(?<name>.*)[[:space:]]\(}
    match.present? ? match[:name].strip : full_name
  end

  def similar_categories
    @similar_categories ||= (related_categories | reverse_related_categories).
      uniq.
      sort_by(&:stars).
      reverse
  end

  # Extended links include the links associated with repos of this category
  # in addition to the ones associated with the category itself,
  # all sorted by reverse published_at date
  def extended_links
    @extended_links ||= (links | links_of_repos).
      uniq.
      sort_by(&:published_at).
      reverse
  end

  def to_param
    "#{id}-#{full_name.parameterize}"
  end

  private

  def links_of_repos
    repos.includes(:links).flat_map(&:links)
  end

  def assign_stars
    self.stars = repos.map(&:stars).reduce(:+) || 0
  end

  def assign_score
    self.score = repos.map(&:score).reduce(:+) || 0
  end

  def assign_repos_count
    self.repos_count = repos.size
  end
end
