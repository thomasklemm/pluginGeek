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
            uniq:         true#,
            #order:        'knight_score DESC'

  # TODO: Counter Cache
  def has_parents?
    parents.length > 0
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
            uniq:         true#,
            #order:        'knight_score DESC'

  # TODO: Cache Couter
  def has_children?
    children_count > 0
  end

  def child_list
    children.map(&:full_name).join(', ')
  end

  # Categories
  has_and_belongs_to_many :categories,
                          uniq: true,
                          order: 'knight_score desc'
  # REVIEW: How can categories be implemented in ordered list fashion?

  def has_categories?
    categories.length > 0
  end

  def category_list
    categories.map(&:full_name).join(', ')
  end

  def category_list=(full_names)
    unless full_names == category_list
      # Prepare
      full_names &&= full_names.split(', ')
      full_names.delete('')
      old_categories = categories.map(&:full_name)

      # Set categories
      self.categories = full_names.map do |full_name|
        Category.find_or_create_by_full_name(full_name.strip)
      end

      # Update category stats
      # REVIEW: There should be a nicer way, maybe using dirty tracking
      new_categories = categories.map(&:full_name)
      cs = (old_categories + new_categories).uniq
      cs.each {|c_full_name| Category.find_by_full_name(c_full_name).save}
    end
  end

  # Languages (through categories)
  include FlagShihTzu
  LANGUAGES = %w(ruby javascript design)
  has_flags :column => 'languages',
            1 => :ruby,
            2 => :javascript,
            3 => :design

  before_save :set_languages
  def set_languages
    langs = categories.map(&:languages).flatten.uniq

    LANGUAGES.each do |lang|
      langs.include?(lang) ? send("#{ lang }=", true) : send("#{ lang }=", false)
    end
  end

  def languages
    langs = begin
      array = []
      LANGUAGES.each { |lang| array << lang if send(lang) }
      array
    end
  end

  def language_list
    languages.join(', ')
  end

  ##
  # Scopes
  # order_by_knight_score
  scope :order_by_knight_score, order('knight_score desc')

  # language(:ruby) / language('ruby')
  scope :language, lambda { |lang| send(lang) if LANGUAGES.include?(lang.to_s) }
  # find_all_by_language(:ruby)
  scope :find_all_by_language, lambda { |lang| language(lang).order_by_knight_score }

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
  # Class methods
  def self.bust_caches
    find_each(&:touch)
  end

  ##
  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :category_list, :parent_list
end
