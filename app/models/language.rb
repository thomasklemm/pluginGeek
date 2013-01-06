# == Schema Information
#
# Table name: languages
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  slug       :string(255)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_languages_on_slug  (slug) UNIQUE
#

class Language < ActiveRecord::Base
  # Constants
  Main = %w(web mobile)
  Web = %w(javascript ruby webdesign python php scala go)
  Mobile = %w(ios android)
  All = (Main + Web + Mobile).uniq

  # FriendlyId
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Hierarchy
  acts_as_tree

  ##
  # Categories and Repos
  has_many :language_classifications

  has_many :categories,
    through: :language_classifications,
    source: :classifier,
    source_type: 'Category',
    uniq: true,
    order: 'categories.knight_score DESC'

  has_many :repos,
    through: :language_classifications,
    source: :classifier,
    source_type: 'Repo',
    uniq: true,
    order: 'repos.knight_score DESC'

  attr_accessible :name
end
