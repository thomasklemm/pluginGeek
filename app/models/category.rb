# == Schema Information
#
# Table name: categories
#
#  created_at       :datetime         not null
#  description      :text
#  draft            :boolean          default(TRUE)
#  full_name        :text             not null
#  id               :integer          not null, primary key
#  knight_score     :integer          default(0)
#  long_description :text
#  slug             :text             not null
#  stars            :integer          default(0)
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_categories_on_knight_score  (knight_score)
#  index_categories_on_slug          (slug) UNIQUE
#

class Category < ActiveRecord::Base
  # Friendly Id using history module (redirecting to new slug if slug changed)
  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]

  # Audits
  audited only: [:full_name, :description]

  # Validations
  validates :full_name, uniqueness: true
  validates :slug, uniqueness: true
  validates :description, length: {maximum: 360}

  # Repos
  has_many  :categorizations
  has_many  :repos,
    through: :categorizations,
    uniq: true,
    order: 'repos.knight_score DESC'

  # Ads
  has_many  :ad_categorizations
  has_many  :ads,
    through: :ad_categorizations,
    uniq: true

  # Languages
  has_many  :language_classifications,
    as: :classifier
  has_many  :languages,
    through: :language_classifications,
    uniq: true

  def language_list
    @languages ||= calculate_language_list
  end

  # only display web and mobile without subcategories
  def calculate_language_list
    langs = languages.map(&:name)
    langs.delete_if {|lang| Language::Web.include?(lang.downcase)} if langs.include? 'Web'
    langs.delete_if {|lang| Language::Mobile.include?(lang.downcase)}  if langs.include? 'Mobile'
    langs.join(', ')
  end

  # Links
  has_many :link_relationships,
    as: :linkable
  has_many :links,
    through: :link_relationships,
    uniq: true,
    order: 'links.published_at DESC'

  # All links including the ones from the repos associated with this category
  # nil.to_a => []
  def deep_links
    l = (links.to_a | repos.joins(:links).includes(:links).flat_map(&:links).to_a).uniq
    l.sort_by(&:published_at).reverse
  end

  # Scopes
  # Ordering by score
  scope :order_by_score, order('categories.knight_score DESC')



  ##
  # Getters and defaults
  def description
    self[:description] || ''
  end

  def description_with_fallback
    description.present? ? description : '<em>Please add a description to this category.</em>'
  end

  def stars
    self[:stars] || 0
  end

  def knight_score
    self[:knight_score] || 0
  end


  def popular_repos
    repos[0..2].to_a.map(&:name).join(', ') || ''
  end

  # nil.to_a => []
  def further_repos
    repos[3..1000].to_a.map(&:name).join(', ') || ''
  end

  def name
    @name ||= begin
      match = full_name.match %r{(?<name>.*)[[:space:]]\(}
      match.present? ? match[:name].strip : full_name
    end
  end

  ##
  # Callbacks
  # Set stats before saving
  before_save :set_stars
  before_save :set_knight_score

  def set_stars
    # load whole record as knight_score will be set as well
    self.stars = repos.map(&:stars).reduce(:+) || 0
  end

  def set_knight_score
    self.knight_score = repos.map(&:knight_score).reduce(:+) || 0
  end

  # Update languages of each associated repo after commit
  # and expire repos
  after_commit :update_repo_languages
  def update_repo_languages
    repos(true).each { |repo| repo.save }
  end

  # Set languages
  before_save :set_languages
  def set_languages
    match = full_name.match %r{\((?<languages>.*)\)}
    if match.present?
      langs = match[:languages].downcase.split('/')
      langs = langs.map(&:strip)

      # reset languages
      self.languages = []

      # set provided languages
      langs.each do |lang|
        language = Language.find_by_slug(lang)
        self.languages << language if language
      end

      # add sublanguages if appropriate
      add_web_languages if langs.include?('web')
      add_mobile_languages if langs.include?('mobile')
    end
  end

  def add_web_languages
    Language::Web.each do |lang|
      language = Language.find_by_slug(lang)
      self.languages << language if language
    end
  end

  def add_mobile_languages
    Language::Mobile.each do |lang|
      language = Language.find_by_slug(lang)
      self.languages << language if language
    end
  end

  # Autocomplete category full_names on repo#edit
  def self.full_names_for_autocomplete
    order_by_score.pluck(:full_name).to_json
  end

  ##
  # Callbacks
  # Expire repos on category changes
  after_commit :expire_repos, if: :persisted?
  def expire_repos
    repos.each(&:touch)
  end

  # Save categories when expiring to update statistics
  def self.expire(category_names)
    categories = self.where(full_name: category_names)
    categories.each(&:save)
  end

  # Mass Assignment Whitelist
  attr_accessible :full_name, :description, :draft
end
