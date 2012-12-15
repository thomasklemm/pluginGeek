# == Schema Information
#
# Table name: repos
#
#  id                 :integer          not null, primary key
#  full_name          :string(255)      not null
#  owner              :string(255)
#  name               :string(255)
#  stars              :integer          default(0)
#  github_description :text
#  github_url         :string(255)
#  homepage_url       :string(255)
#  knight_score       :integer          default(0)
#  github_updated_at  :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  update_success     :boolean          default(FALSE)
#  languages          :integer          default(0)
#  description        :text
#  label              :text
#

class Repo < ActiveRecord::Base
  # Friendly ID
  extend FriendlyId
  friendly_id :full_name

  # Validations
  validates :full_name, presence: true, uniqueness: true

  validates :description, length: {maximum: 360}
  validates :label,       length: {maximum: 60}

  ##
  # Audits
  # audited only: [:full_name, :description, :label]

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
    parents.size > 0
  end

  # def parent_list
  #   parents.map(&:full_name).join(', ')
  # end

  # def parent_list=(full_names)
  #   full_names.delete("")
  #   unless full_names.join(', ') == parent_list
  #     self.parents = full_names.map do |full_name|
  #       Repo.find_by_full_name(full_name.strip)
  #     end
  #   end
  # end

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
    children.size > 0
  end

  def child_list
    children.map(&:full_name).join(', ')
  end

  # Categories
  has_many  :categorizations
  has_many  :categories,
            through: :categorizations,
            uniq: true,
            order: 'knight_score DESC'

  def has_categories?
    categories.size > 0
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

      # Touch self (based on online tests)
      self.touch
    end
  end

  # Languages (through categories)
  include FlagShihTzu
  LANGUAGES = %w(ruby javascript webdesign mobile ios android)
  has_flags :column => 'languages',
            1 => :ruby,
            2 => :javascript,
            3 => :webdesign,
            4 => :mobile,
            5 => :ios,
            6 => :android

  before_save :set_languages
  def set_languages
    langs = categories(true).map(&:languages).flatten.uniq

    LANGUAGES.each do |lang|
      langs.include?(lang) ? send("#{ lang }=", true) : send("#{ lang }=", false)
    end

    # if mobile then ios and android true, too
    self.mobile? ? (self.ios = true and self.android = true) : nil
  end

  # All languages in an array
  # e.g. ['ruby'], ['ruby', 'javascript']
  def languages
    langs = LANGUAGES.each_with_object([]) { |lang, array| array << lang if send(lang) }
  end

  def language_list
    languages.join(', ')
  end

  ##
  # Scopes
  # order_by_knight_score
  scope :order_by_knight_score, order('repos.knight_score desc')

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

  # All repos without the given one
  # used in repo#edit to disencourage setting a repo's parent to itself
  def self.all_without(repo)
    order_by_knight_score - [repo]
  end

  # update_failed
  # REVIEW: Maybe a state-machine would help make this nicer
  scope :update_failed, lambda { where('update_success = ?', false) }

  ##
  # Field Defaults
  def name
    self[:name] || self[:full_name].split('/')[1]
  end

  def owner
    self[:owner] || self[:full_name].split('/')[0]
  end

  def homepage_url
    self[:homepage_url] || ""
  end

  def github_updated_at
    self[:github_updated_at] ? self[:github_updated_at].utc : 2.years.ago
  end

  def github_description
    self[:github_description].present? ? self[:github_description] : ""
  end

  def description
    self[:description].present? ? self[:description] : github_description
  end

  def label
    self[:label] || ""
  end

  ##
  # Virtual attributes
  def smart_timestamp
    github_updated_at.iso8601
  end

  ##
  # Swiftype Full-Text Searching
  #
  # Update search index after each transaction
  #
  after_commit :create_document, on: :create
  after_commit :update_document, on: :update
  after_commit :destroy_document, on: :destroy

  def create_document
    SwiftypeIndexWorker.perform_async(model_name, id, :create)
  end

  def update_document
    SwiftypeIndexWorker.perform_async(model_name, id, :update)
  end

  def destroy_document
    SwiftypeIndexWorker.perform_async(model_name, id, :destroy)
  end

  ##
  # Class methods
  def self.bust_caches
    find_each(&:touch)
  end

  ##
  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :description, :label, :category_list, :parent_ids
end
