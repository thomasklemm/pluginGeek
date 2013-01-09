# == Schema Information
#
# Table name: repos
#
#  created_at         :datetime         not null
#  description        :text
#  full_name          :text             not null
#  github_description :text
#  github_updated_at  :datetime
#  homepage_url       :text
#  id                 :integer          not null, primary key
#  knight_score       :integer          default(0)
#  name               :text
#  owner              :text
#  staff_pick         :boolean          default(FALSE)
#  stars              :integer          default(0)
#  update_success     :boolean          default(FALSE)
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_repos_on_full_name     (full_name) UNIQUE
#  index_repos_on_knight_score  (knight_score)
#

class Repo < ActiveRecord::Base
  # Friendly ID
  extend FriendlyId
  friendly_id :full_name

  # Validations
  validates :full_name, presence: true, uniqueness: true
  validates :description, length: {maximum: 360}

  ##
  # Parents
  has_many  :parent_child_relationships,
    class_name:   'RepoRelationship',
    foreign_key:  :child_id,
    dependent:    :destroy

  has_many  :parents,
    through:      :parent_child_relationships,
    source:       :parent,
    uniq:         true

  def has_parents?
    parents.size > 0
  end

  ##
  # Children
  has_many  :child_parent_relationships,
    class_name:   'RepoRelationship',
    foreign_key:  :parent_id,
    dependent:    :destroy

  has_many  :children,
    through:      :child_parent_relationships,
    source:       :child,
    uniq:         true

  # Review: Add counter cache?
  def has_children?
    children.size > 0
  end

  def child_list
    children.pluck(:full_name).join(', ')
  end

  ##
  # Categories
  has_many  :categorizations
  has_many  :categories,
    through: :categorizations,
    uniq: true,
    order: 'categories.knight_score DESC'

  def has_categories?
    categories.size > 0
  end

  # for tag input
  def category_list
    # Review: more efficient 'pluck' breaks
    categories.map(&:full_name).join(', ')
  end

  # set categories, handle changes in tag input
  def category_list=(new_list)
    if new_list != category_list
      # Review: more efficient 'pluck' breaks
      old_ones = categories.map(&:full_name)

      full_names = new_list.split(', ')
      full_names.delete('')
      full_names = full_names.compact.map(&:strip)

      self.categories = full_names.map do |full_name|
        Category.find_or_create_by_full_name(full_name)
      end

      new_ones = categories.map(&:full_name)

      # Expire caches
      expire_old_and_new_categories(old_ones, new_ones)
      expire_self
   end
  end

  # Expire cache when associations changed
  def expire_self
    self.touch
  end

  def expire_old_and_new_categories(old_ones, new_ones)
    ones = old_ones | new_ones
    ones.each do |full_name|
      category = Category.find_by_full_name(full_name)
      category.save if category # trigger callbacks that update statistics by saving instead of touching
    end
  end

  ##
  # Languages
  has_many  :language_classifications,
    as: :classifier
  has_many  :languages,
    through: :language_classifications,
    uniq: true

  ##
  # Links
  has_many :link_relationships,
    as: :linkable
  has_many :links,
    through: :link_relationships,
    uniq: true,
    order: 'links.published_at DESC'

  ##
  # Scopes
  scope :order_by_knight_score, order('repos.knight_score DESC')

  # All repos without the given one
  # used in repo#edit to disencourage setting a repo's parent to itself
  def self.all_without(repo)
    order_by_knight_score - [repo]
  end

  # REVIEW: Maybe a state-machine would help make this nicer
  scope :update_failed, lambda { where('update_success = ?', false) }

  ##
  # Audits
  audited only: [:full_name, :description, :label]

  ##
  # Field Defaults and Virtual attributes
  def name
    self[:name] || self[:full_name].split('/')[1]
  end

  def owner
    self[:owner] || self[:full_name].split('/')[0]
  end

  def github_url
    "https://github.com/#{full_name}"
  end

  def homepage_url
    self[:homepage_url].present? ? self[:homepage_url] : github_url
  end

  def github_updated_at
    self[:github_updated_at].present? ? self[:github_updated_at].utc : 2.years.ago.utc
  end

  def github_description
    self[:github_description].present? ? self[:github_description] : ''
  end

  def description
    self[:description].present? ? self[:description] : github_description
  end

  def language_list
    languages.map(&:name).join(', ')
  end

  # for relative timestamp using jquery timeago
  def timestamp
    github_updated_at.utc
  end

  # Alternatives
  # repos in associated categories, sorted by knight_score
  def alternatives
    @alternatives ||= find_alternatives
  end

  def find_alternatives
    alternatives = categories.flat_map(&:repos).uniq.sort_by(&:knight_score).reverse
    alternatives.delete(self)
    alternatives
  end

  def has_alternatives?
    alternatives.size > 0
  end

  def alternatives_star_range
    alt_stars = alternatives.map(&:stars)
    "<i class='icon-star'></i>#{ alt_stars.max } &ndash; <i class='icon-star'></i>#{ alt_stars.min }".html_safe
  end

  def parents_and_children
    parents | children
  end

  ##
  # Callbacks
  before_save :set_languages
  def set_languages
    self.languages = categories.flat_map(&:languages).uniq
  end

  ##
  # Swiftype Full-Text Searching
  #
  # Update search index after each transaction
  #
  # after_commit :create_document, on: :create
  # after_commit :update_document, on: :update
  # after_commit :destroy_document, on: :destroy

  # def create_document
  #   SwiftypeIndexWorker.perform_async('Repo', id, :create)
  # end

  # def update_document
  #   SwiftypeIndexWorker.perform_async('Repo', id, :update)
  # end

  # def destroy_document
  #   SwiftypeIndexWorker.perform_async('Repo', id, :destroy)
  # end

  ##
  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :description, :label, :category_list, :parent_ids
end
