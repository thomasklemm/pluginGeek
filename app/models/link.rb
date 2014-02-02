class Link < ActiveRecord::Base
  validates :url,
    :title,
    :published_at,
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

  def extended_categories
    categories | categories_of_repos
  end

  private

  def categories_of_repos
    repos.flat_map(&:categories).uniq
  end
end
