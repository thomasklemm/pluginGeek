# == Schema Information
#
# Table name: repos
#
#  id                   :integer          not null, primary key
#  full_name            :string(255)      not null
#  owner                :string(255)
#  name                 :string(255)
#  watchers             :integer          default(0)
#  forks                :integer          default(0)
#  description          :text
#  github_url           :string(255)
#  homepage_url         :string(255)
#  knight_score         :integer          default(0)
#  github_updated_at    :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  label                :string(255)
#  cached_category_list :string(255)
#  update_success       :boolean          default(FALSE)
#  temp_parent_list     :string(255)
#

class Repo < ActiveRecord::Base
  # Friendly ID
  extend FriendlyId
  friendly_id :full_name

  # Tagging
  acts_as_ordered_taggable_on :categories

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

  def parent_list
    parents.map(&:full_name).join(', ')
  end

  def parent_list=(full_names)
    full_names.delete("")
    self.parents = full_names.map do |full_name|
      Repo.find_by_full_name(full_name.strip)
    end
  end

  def child_list
    children.map(&:full_name).join(', ')
  end

  def has_children?
    children.size > 0
  end

  # Modules
  include InstancesHelper

  ##
  # Scopes
  #
  # find_all_by_language('ruby'),
  #   order by knight_score
  scope :find_all_by_language, lambda {  |language| tagged_with(language, on: :languages) }
  scope :ordered_find_all_by_language, lambda { |language| find_all_by_language(language).order_by_knight_score }

  # find_all_by_category('awesome_category'),
  #   order by knight_score
  scope :find_all_by_category, lambda { |category_name| tagged_with(category_name, on: :categories) }
  scope :ordered_find_all_by_category, lambda { |category_name| find_all_by_category(category_name).order_by_knight_score }

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
