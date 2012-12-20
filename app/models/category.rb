# == Schema Information
# Schema version: 20121218083327
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  slug             :string(255)      not null
#  knight_score     :integer          default(0)
#  description      :text
#  long_description :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  full_name        :string(255)      not null
#  name             :string(255)
#  stars            :integer          default(0)
#
# Indexes
#
#  index_categories_on_knight_score  (knight_score)
#  index_categories_on_slug          (slug) UNIQUE
#

class Category < ActiveRecord::Base
  # Friendly Id
  #   using history module (redirecting to new slug if slug changed)
  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]

  ##
  # Associations
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

  ##
  # Languages
  has_many  :language_classifications,
            as: :classifier
  has_many  :languages,
            through: :language_classifications,
            uniq: true

  ##
  # Scopes
  scope :order_by_knight_score, order('categories.knight_score DESC')

  ##
  # Validations
  validates :full_name, uniqueness: true
  validates :slug, uniqueness: true
  validates :description, length: {maximum: 360}

  ##
  # Audits
  audited only: [:full_name, :description]

  ##
  # Getters and defaults
  def description
    self[:description] || ''
  end

  def stars
    self[:stars] || 0
  end

  def knight_score
    self[:knight_score] || 0
  end

  def language_list
    languages.map(&:name).join(', ')
  end

  def popular_repos
    (repos[0..2] && repos[0..2].map(&:name).join(', ')) || ''
  end

  def further_repos
    (repos[3..100] && repos[0..3].map(&:name).join(', ')) || ''
  end

  def name
    @name ||= begin
      match = full_name.match %r{(?<name>.*)[[:space:]]\(}
      match[:name].try(:strip) || full_name
    end
  end

  # to ease transition, replace all instance though
  def short_description
    self[:description] || ''
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

  ##
  # Swiftype Full-Text Searching
  #
  # Update search index after each transaction
  after_commit :create_document, on: :create
  after_commit :update_document, on: :update
  after_commit :destroy_document, on: :destroy

  def create_document
    SwiftypeIndexWorker.perform_async('Category', id, :create)
  end

  def update_document
    SwiftypeIndexWorker.perform_async('Category', id, :update)
  end

  def destroy_document
    SwiftypeIndexWorker.perform_async('Category', id, :destroy)
  end

  # Mass Assignment Whitelist
  attr_accessible :full_name, :description, :label
end
