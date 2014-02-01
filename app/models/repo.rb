class Repo < ActiveRecord::Base
  validates :full_name,
    presence: true,
    uniqueness: true

  scope :order_by_name,  -> { order(full_name: :asc) }
  scope :order_by_score, -> { order(score: :desc) }

  scope :ids_and_full_names, -> { select([:id, :full_name]).order_by_score }
  scope :ids_and_full_names_without, ->(repo) { ids_and_full_names.where.not(id: repo.id) }

  has_many :categories,
    -> { order(score: :desc) },
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
    full_name
  end
end
