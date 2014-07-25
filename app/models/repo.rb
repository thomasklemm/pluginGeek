class Repo < ActiveRecord::Base
  validates :owner_and_name,
    presence: true,
    format: { with: REPO_OWNER_AND_NAME_REGEXP },
    uniqueness: { case_sensitive: false }

  # Case-insensitive search
  def self.find_by_owner_and_name(owner_and_name)
    search(owner_and_name).first
  end

  def self.find_by_owner_and_name!(owner_and_name)
    search(owner_and_name).first!
  end

  scope :default_order, -> { order_by_score }
  scope :for_picker, -> { order_by_score }
  scope :order_by_name,  -> { order(owner_and_name: :asc) }
  scope :order_by_score, -> { order(score: :desc) }
  scope :search, -> (owner_and_name) { where("lower(owner_and_name) = ?", owner_and_name.downcase) }

  has_many :categories,
    through: :categorizations
  has_many :categorizations,
    class_name: 'Repo::Categorization',
    dependent: :destroy

  has_many :parents,
    through: :parent_child_relationships,
    source: :parent
  has_many :parent_child_relationships,
    class_name: 'Repo::Relationship',
    foreign_key: :child_id,
    dependent: :destroy

  has_many :children,
    through: :child_parent_relationships,
    source: :child
  has_many :child_parent_relationships,
    class_name: 'Repo::Relationship',
    foreign_key: :parent_id,
    dependent: :destroy

  has_many :links,
    -> { uniq },
    through: :link_relationships
  has_many :link_relationships,
    class_name: 'Link::Relationship',
    as: :linkable,
    dependent: :destroy

  def assignable_categories
    Category.for_picker
  end

  def assignable_parents
    Repo.for_picker.without(self)
  end

  def score
    self[:score] || 0
  end

  def stars
    self[:stars] || 0
  end

  def to_param
    owner_and_name
  end
end
