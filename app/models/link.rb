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
    through: :link_relationships,
    source: :linkable,
    source_type: 'Category',
    uniq: true

  has_many :repos,
    through: :link_relationships,
    source: :linkable,
    source_type: 'Repo',
    uniq: true

  def extended_categories
    categories | categories_of_repos
  end

  # Expire caches of all associated repos,
  # categories, and categories of repos
  after_commit :expire_repos
  after_commit :expire_categories
  after_commit :expire_categories_of_repos

  private

  def categories_of_repos
    repos.flat_map(&:categories).uniq
  end

  def expire_repos
    repos.update_all(updated_at: Time.current)
  end

  def expire_categories
    categories.update_all(updated_at: Time.current)
  end

  def expire_categories_of_repos
    categories_of_repos.each { |category| category.update_column(:updated_at, Time.current) }
  end
end
