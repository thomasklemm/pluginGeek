class Link < ActiveRecord::Base
  # Validations
  validates :url, :title, :published_at, presence: true

  # Maker, the person who submits the link
  belongs_to :submitter, class_name: 'User'
  validates :submitter, presence: true

  # Repos and categories
  has_many :link_relationships,
    dependent: :destroy

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

  def extended_categories
    categories | categories_of_repos
  end

  private

  def categories_of_repos
    repos.flat_map(&:categories).uniq
  end
end
