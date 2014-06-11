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
    dependent: :destroy
end
