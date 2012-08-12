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
  ###
  #   Modules
  ###
  # FriendlyId
  extend FriendlyId
  friendly_id :full_name

  # Tagging
  acts_as_ordered_taggable_on :categories
  acts_as_taggable_on :languages, :children

  ###
  #   Scopes & Validations
  ###
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

  ###
  #   Field Defaults
  ###
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

  ###
  #   Virtual Attributes
  ###
  # Has Children
  # Does the repo have children associated with it?
  def has_children?
    cached_child_list.present?
  end

  ###
  #   Life-Cycle Callbacks
  ###
  # Touch parents after safe
  #   cache auto-expiration
  after_save :touch_parents
  def touch_parents
    # Find parents
    parents = Repo.find_all_by_full_name(child_list)
    # Touch each parent
    parents.each { |parent| parent.touch }
  end

  # Remove child from parents
  #  after destorying a repo
  after_destroy :remove_child_from_parents
  def remove_child_from_parents
    # Find parents
    parents = Repo.find_all_by_full_name(child_list)
    parents.each do |parent|
      # Remove repo from parent's child_list
      parent.child_list.remove(full_name)
      parent.save
    end
  end

  # Determine Languages
  #  and assign them to language_list
  before_save :determine_languages
  def determine_languages
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

  # Cache Taggings
  # on categories, children and languages
  # before save
  before_save :cache_taggings
  def cache_taggings
    cache_category_list
    cache_child_list
    cache_language_list
  end

  def cache_category_list
    self.cached_category_list = category_list.to_s
  end

  def cache_child_list
    self.cached_child_list = child_list.to_s
  end

  def cache_language_list
    self.cached_language_list = language_list.to_s
  end


  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :category_list
end
