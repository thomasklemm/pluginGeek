# == Schema Information
#
# Table name: links
#
#  author       :text
#  author_url   :text
#  created_at   :datetime         not null
#  id           :integer          not null, primary key
#  published_at :date             not null
#  submitter_id :integer
#  title        :text             not null
#  updated_at   :datetime         not null
#  url          :text             not null
#

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

  private

  def categories_of_repos
    repos.flat_map(&:categories).uniq
  end
end
