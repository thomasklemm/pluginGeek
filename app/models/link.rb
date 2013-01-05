# == Schema Information
# Schema version: 20130104093506
#
# Table name: links
#
#  id           :integer          not null, primary key
#  url          :string(255)
#  title        :string(255)
#  author       :string(255)
#  author_url   :string(255)
#  published_at :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Link < ActiveRecord::Base
  validates :url, :title, presence: true

  ##
  # Repos and categories
  has_many :link_relationships

  has_many :repos,
    through: :link_relationships,
    source: :linkable,
    source_type: 'Repo',
    uniq: true,
    order: 'repos.knight_score DESC'

  has_many :categories,
    through: :link_relationships,
    source: :linkable,
    source_type: 'Category',
    uniq: true,
    order: 'categories.knight_score DESC'

  attr_accessible :author, :author_url, :published_at, :title, :url
end
