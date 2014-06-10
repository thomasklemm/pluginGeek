class Repo < ActiveRecord::Base
  validates :owner_and_name,
    presence: true,
    uniqueness: { case_sensitive: false }

  scope :order_by_name,  -> { order(owner_and_name: :asc) }
  scope :order_by_score, -> { order(score: :desc) }

  scope :for_picker, -> { select([:id, :owner_and_name]).order_by_score }
  scope :without, -> (repo) { where.not(id: repo.id) }

  scope :ids_and_owner_and_names, -> { select([:id, :owner_and_name]).order_by_score }
  scope :ids_and_owner_and_names_without, ->(repo) { ids_and_owner_and_names.where.not(id: repo.id) }

  # Case-insensitive search
  scope :find_by_owner_and_name,  ->(query) { where("lower(owner_and_name) = ?", query.downcase).first }
  scope :find_by_owner_and_name!, ->(query) { where("lower(owner_and_name) = ?", query.downcase).first! }

  has_many :categories,
    -> { order(score: :desc) },
    through: :categorizations
  has_many :categorizations,
    dependent: :destroy

  def assignable_categories
    Category.for_picker
  end

  has_many :parents,
    through:      :parent_child_relationships,
    source:       :parent
  has_many :parent_child_relationships,
    class_name:   'RepoRelationship',
    foreign_key:  :child_id,
    dependent:    :destroy

  has_many :children,
    through:      :child_parent_relationships,
    source:       :child
  has_many :child_parent_relationships,
    class_name:   'RepoRelationship',
    foreign_key:  :parent_id,
    dependent:    :destroy

  def parents_and_children
    parents | children
  end

  has_many :links,
    -> { uniq },
    through: :link_relationships
  has_many :link_relationships,
    as: :linkable,
    dependent: :destroy

  def stars
    self[:stars] || 0
  end

  def score
    self[:score] || 0
  end

  def to_param
    owner_and_name
  end
end
