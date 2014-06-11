class Repo < ActiveRecord::Base
  validates :owner_and_name,
    presence: true,
    format: { with: VALID_REPO_OWNER_AND_NAME },
    uniqueness: { case_sensitive: false }

  # Case-insensitive search
  scope :find_by_owner_and_name,  ->(query) { where("lower(owner_and_name) = ?", query.downcase).first }
  scope :find_by_owner_and_name!, ->(query) { where("lower(owner_and_name) = ?", query.downcase).first! }

  scope :default_order, -> { order_by_score }
  scope :for_picker, -> { order_by_score }
  scope :order_by_name,  -> { order(owner_and_name: :asc) }
  scope :order_by_score, -> { order(score: :desc) }

  has_many :categories,
    through: :categorizations
  has_many :categorizations,
    dependent: :destroy

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

  has_many :links,
    -> { uniq },
    through: :link_relationships
  has_many :link_relationships,
    as: :linkable,
    dependent: :destroy

  def assignable_categories
    Category.for_picker
  end

  def assignable_parents
    Repo.for_picker.without(self)
  end

  def parents_and_children
    parents | children
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
