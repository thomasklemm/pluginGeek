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
#  cached_child_list    :string(255)
#  cached_language_list :string(255)
#  update_success       :boolean          default(FALSE)
#

class Repo < ActiveRecord::Base
  ##
  # Modules

  # FriendlyId
  extend FriendlyId
  friendly_id :full_name

  # Tagging
  acts_as_ordered_taggable_on :categories
  acts_as_taggable_on :languages, :parents

  # InstancesHelper
  include InstancesHelper

  ##
  # Scopes & Validations

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

  # Validations
  validates :full_name, presence: true, uniqueness: true

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
  # Virtual Attributes

  # Has Children
  #  Does the repo have children associated with it?
  def has_children?
    cached_child_list.present?
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
    update_repo
    update_categories
  end

  def update_repo
    determine_languages_from_categories
    cache_category_list
    cache_language_list
    self.save
  end

  def update_categories
    category_list.each {|category_name| update_category(category_name)}
  end

  ##
  # UPDATE REPO

  # Determine Languages and assign them to language_list
  def determine_languages_from_categories
    languages_array = []
    # category_list can be called before save
    category_list.each do |category_name|
      match = /\((?<languages>.*)\)/.match(category_name)
      # if there is no match, match will be nil
      languages_string = match[:languages] if match
      # add the first language of every category as a repo's language
      (languages_array << languages_string.split('/')[0].downcase) if languages_string
    end
    self.language_list = languages_array
  end

  def cache_category_list
    self.cached_category_list = category_list.to_s
  end

  def cache_language_list
    self.cached_language_list = language_list.to_s
  end

  ##
  # UPDATE PARENT/S

  after_save :update_parents
  def update_parents
    # including parents from which it has been removed
    @changes_to_parent_list = changes[:parent_list]
    if @changes_to_parent_list.present?
      old_parent_list = @changes_to_parent_list[0].split(', ')
      new_parent_list = @changes_to_parent_list[1]
      list = old_parent_list.concat(new_parent_list).flatten.uniq
      list.each {|parent_full_name| cache_child_list_on_parent(parent_full_name)}
    end
  end

  # Update child list on parent
  def cache_child_list_on_parent(parent_full_name)
    parent = Repo.find_by_full_name(parent_full_name)
    if parent.present?
      children = Repo.tagged_with(parent.full_name, on: :parents)
      if children.present?
        child_array = children.map {|child| child.full_name}
        parent.cached_child_list = child_array.join(', ')
        parent.save
      end
    end
  end

  # Remove parent from children after destroying a repo
  after_destroy :remove_parent_from_children
  def remove_parent_from_children
    children = Repo.tagged_with(full_name, on: :parents)
    if children.present?
      children.each do |child|
        child.parent_list.remove(full_name)
        child.save
      end
    end
  end

  ##
  # UPDATE CATEGORIES

  # Invalidate timestamp of category on repo update
  def update_category(name)
    if name.present?
      categories = Category.find_all_by_name(name)
      categories.each {|category| category.touch}
    end
  end

  ##
  # Class methods

  # Bust Caches by touching every repo
  def self.bust_caches
    find_each { |repo| repo.touch }
  end

  # Clean up untagged repos
  # RISK: ONE MIGHT DELETE REPOS THAT CARRY NO TAG
  # BUT ARE CHILDREN TO SOME OTHER REPO
  # def self.clean
  #   repos = find_all_by_cached_category_list('')
  #   repos.each { |repo| repo.destroy }
  # end

  ##
  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :category_list, :label, :parent_list
end
