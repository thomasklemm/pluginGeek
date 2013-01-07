# == Schema Information
#
# Table name: links
#
#  author       :text
#  author_url   :text
#  created_at   :datetime         not null
#  id           :integer          not null, primary key
#  published_at :date             not null
#  title        :text             not null
#  updated_at   :datetime         not null
#  url          :text             not null
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
    uniq: true
    # order: 'repos.knight_score DESC'

  has_many :categories,
    through: :link_relationships,
    source: :linkable,
    source_type: 'Category',
    uniq: true
    # order: 'categories.knight_score DESC'

  # Convert '@mperham' to 'https://twitter.com/mperham'
  def author_url
    url = self[:author_url] || ''
    url.start_with?('@') and url = "https://twitter.com/#{ url.gsub('@', '') }"
  end

  attr_accessible :author, :author_url, :published_at, :title, :url, :repo_ids, :category_ids
end
