# == Schema Information
#
# Table name: repos
#
#  id                :integer          not null, primary key
#  full_name         :string(255)      not null
#  owner             :string(255)
#  name              :string(255)
#  stars             :integer          default(0)
#  description       :text
#  github_url        :string(255)
#  homepage_url      :string(255)
#  knight_score      :integer          default(0)
#  github_updated_at :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  update_success    :boolean          default(FALSE)
#  languages         :integer
#

class Repo < ActiveRecord::Base
  # Friendly ID
  extend FriendlyId
  friendly_id :full_name

  # Validations
  validates :full_name, presence: true, uniqueness: true

  ##
  # Associations
  #
  # Parents
  has_many  :parent_child_relationships,
            class_name:   'RepoRelationship',
            foreign_key:  :child_id,
            dependent:    :destroy

  has_many  :parents,
            through:      :parent_child_relationships,
            source:       :parent,
            uniq:         true,
            order:        'knight_score DESC'

  # TODO: Counter Cache
  def has_parents?
    parents.size > 0
  end

  def parent_list
    parents.map(&:full_name).join(', ')
  end

  def parent_list=(full_names)
    full_names.delete("")
    unless full_names.join(', ') == parent_list
      self.parents = full_names.map do |full_name|
        Repo.find_by_full_name(full_name.strip)
      end
    end
  end

  # Children
  has_many  :child_parent_relationships,
            class_name:   'RepoRelationship',
            foreign_key:  :parent_id,
            dependent:    :destroy

  has_many  :children,
            through:      :child_parent_relationships,
            source:       :child,
            uniq:         true,
            order:        'knight_score DESC'

  # TODO: Cache Couter
  def has_children?
    children.size > 0
  end

  def child_list
    children.map(&:full_name).join(', ')
  end

  # Categories
  has_and_belongs_to_many :categories,
                          uniq: true

  def has_categories?
    categories.size > 0
  end

  def category_list
    categories.order_by_knight_score.map(&:name_and_languages).join(', ')
  end

  def category_list=(names_and_languages)
    names_and_languages.delete('')
    unless names_and_languages.join(', ') == category_list
      self.categories = names_and_languages.map do |name_and_languages|
        Category.where(name_and_languages: name_and_languages.strip).first_or_create
      end
    end
  end

  # Languages (through categories)
  def languages
    # Maybe sort by how often each language occurs
    categories.map(&:languages).flatten.uniq
  end

  def language_list
    languages.join(', ')
  end

  ##
  # Scopes
  #
  # TODO: find_all_by_language('ruby')
  #
  # order_by_knight_score,
  #   order repos by descending knight_score
  scope :order_by_knight_score, lambda { order('knight_score desc') }

  # most_recent_by_language('ruby')
  #   find the timestamp of the most recently updated repo
  #   with fallback on a current 10.seconds window
  def self.timestamp_by_language(language)
    if timestamp = find_all_by_language(language).maximum(:updated_at)
      timestamp = timestamp.utc.to_s(:number)
    else
      DateTime.now.utc.to_s(:number).slice(0..(-2))
    end
  end

  # update_failed
  scope :update_failed, lambda { where('update_success = ?', false) }

  ##
  # Field Defaults
  def name
    self[:name] || self[:full_name].split('/')[1]
  end

  def owner
    self[:owner] || self[:full_name].split('/')[0]
  end

  def description
    self[:description] || 'No description. Add one on Github.'
  end

  def homepage_url
    self[:homepage_url] || ''
  end

  def github_updated_at
    self[:github_updated_at] || (Time.now - 2.years)
  end
  ##
  # Update Actions
  #
  # When updating a repo via repos#update these operations should be performed:
  #
  # 1) Determine Languages from Categories
  # 2) Cache Lists
  # 3) Update categories
  #
  # Updating parents is implemented as an after_save callback
  # as it need access to the dirty object with changes tracked
  # REVIEW: Can changes be persisted somehow?

  def after_repo_update
    update_categories
  end

  def update_categories
    category_list.each {|category_name| update_category(category_name)}
  end

  def cache_category_list
    self.cached_category_list = category_list.to_s
  end

  # Invalidate timestamp of category on repo update
  def update_category(name)
    if name.present?
      categories = Category.find_all_by_name(name)
      categories.each {|category| category.touch}
    end
  end

  ##
  # Class methods
  #
  # Bust Caches by touching every repo
  def self.bust_caches
    find_each { |repo| repo.touch }
  end

  ##
  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :category_list, :parent_list, :label
end
