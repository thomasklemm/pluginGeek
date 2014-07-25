class Link < ActiveRecord::Base
  validates :url,
    :title,
    :submitter,
    presence: true

  belongs_to :submitter,
    class_name: 'User'

  has_many :categories,
    -> { uniq },
    through: :link_relationships,
    source: :linkable,
    source_type: 'Category'
  has_many :repos,
    -> { uniq },
    through: :link_relationships,
    source: :linkable,
    source_type: 'Repo'
  has_many :link_relationships,
    class_name: 'Link::Relationship',
    dependent: :destroy

  def assignable_categories
    Category.for_picker
  end

  def assignable_repos
    Repo.for_picker
  end
end
