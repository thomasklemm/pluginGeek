class Language < ActiveRecord::Base
  # Constants
  Main = %w(web mobile)
  Web = %w(javascript ruby webdesign python php scala go)
  Mobile = %w(ios android)
  All = (Main + Web + Mobile).uniq

  # FriendlyId
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Validations
  validates :name, presence: true

  # Hierarchy
  acts_as_tree

  # Classifications
  has_many :language_classifications,
    dependent: :destroy

  # Categories
  has_many :categories,
    -> { order('draft ASC, categories.score DESC').uniq },
    through: :language_classifications,
    source: :classifier,
    source_type: 'Category'

  # Repos
  has_many :repos,
    -> { order('repos.score DESC').uniq },
    through: :language_classifications,
    source: :classifier,
    source_type: 'Repo'
end
