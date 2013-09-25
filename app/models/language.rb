class Language < ActiveRecord::Base
  # Constants
  Main = %w(web mobile)
  Web = %w(javascript ruby webdesign python php scala go)
  Mobile = %w(ios android)
  All = (Main + Web + Mobile).uniq

  def to_param
    name
  end

  # Validations
  validates :name, presence: true

  # Hierarchy
  acts_as_tree

  # Classifications
  has_many :language_classifications,
    dependent: :destroy

  # Categories
  has_many :categories,
    -> { order(full_name: :desc) },
    through: :language_classifications,
    source: :classifier,
    source_type: 'Category'

  # Repos
  has_many :repos,
    -> { order(full_name: :desc) },
    through: :language_classifications,
    source: :classifier,
    source_type: 'Repo'
end
