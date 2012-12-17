# == Schema Information
# Schema version: 20121217114014
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  slug              :string(255)      not null
#  knight_score      :integer          default(0)
#  short_description :text
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  full_name         :string(255)      not null
#  languages         :integer          default(0)
#  name              :string(255)
#  stars             :integer          default(0)
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
  # Audits
  audited only: [:full_name, :short_description, :description]

  ##
  # Associations
  # Repos
  has_many  :categorizations
  has_many  :repos,
            through: :categorizations,
            order: 'knight_score desc'

  # Ads
  has_many  :ad_categorizations
  has_many  :ads,
            through: :ad_categorizations

  ##
  # Languages
  has_many  :language_classifications,
            as: :classifier
  has_many  :languages,
            through: :language_classifications,
            uniq: true

  ##
  # Scopes
  scope :order_by_knight_score, order('categories.knight_score desc')

  ##
  # Validations
  validates :full_name, uniqueness: true
  validates :slug, uniqueness: true
  validates :short_description, length: {maximum: 360}

  ##
  # Setters
  def full_name=(new_full_name)
    if new_full_name != full_name
      # Set new full_name
      super

      # Set name
      md = new_full_name.match %r{(?<name>.*)[[:space:]]\(}
      self[:name] = md.present? ? md[:name].strip : new_full_name.strip

      # Set language_list
      set_languages(new_full_name)
    end
  end

  # REVIEW: Mark name readonly or even make virtual attribute (only set via full_name)
  def name=(new)
    raise 'DO NET SET NAME ON CATEGORY; SET FULL_NAME INSTEAD!'
  end

  # Languages
  def set_languages(new_full_name)
    md = new_full_name.match %r{\((?<languages>.*)\)}
    if md.present?
      langs = md[:languages].downcase.split('/')

      self.languages = langs.map do |lang|
        Language.find_by_slug(lang.strip)
      end.compact

      if language
      Language::Web.each do |lang|
        language = Language.find_by_slug(lang)
        self.languages << language if language
      end

      Language::Mobile.each do |lang|
        language = Language.find_by_slug(lang)
        self.languages << language if language
      end
    end
  end

  # Update languages of associated repos after commit
  after_commit :update_repo_languages
  def update_repo_languages
    repos(true).each { |repo| repo.save }
  end

  def language_list
    languages.map(&:name).join(', ')
  end

  def short_description
    self[:short_description].try(:html_safe) || " "
  end

  def popular_repos
    (repos[0..2] && repos[0..2].map(&:name).join(', ')) || ''
  end

  def further_repos
    (repos[3..100] && repos[0..3].map(&:name).join(', ')) || ''
  end

  ##
  # Set Stats in Callbacks
  before_save :set_stars
  before_save :set_knight_score

  def set_stars
    self.stars = repos.map(&:stars).reduce(:+) || 0
  end

  def set_knight_score
    self.knight_score = repos.map(&:knight_score).reduce(:+) || 0
  end

  # Description
  #   saved as markdown, rendered as html
  include MarkdownHelper  # use the same rendering settings everywhere
  def description
    d = self[:description] || " "
    @description ||= markdown.render(d).html_safe
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
    SwiftypeIndexWorker.perform_async('Category', id, :create)
  end

  def update_document
    SwiftypeIndexWorker.perform_async('Category', id, :update)
  end

  def destroy_document
    SwiftypeIndexWorker.perform_async('Category', id, :destroy)
  end

  ##
  # Mass Assignment Whitelist
  attr_accessible :full_name, :short_description, :description, :label
end
# == Schema Information
# Schema version: 20121217170908
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  slug              :string(255)      not null
#  knight_score      :integer          default(0)
#  short_description :text
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  full_name         :string(255)      not null
#  name              :string(255)
#  stars             :integer          default(0)
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
  # Audits
  audited only: [:full_name, :short_description, :description]

  ##
  # Associations
  # Repos
  has_many  :categorizations
  has_many  :repos,
            through: :categorizations,
            order: 'knight_score desc'

  # Ads
  has_many  :ad_categorizations
  has_many  :ads,
            through: :ad_categorizations

  ##
  # Languages
  has_many  :language_classifications,
            as: :classifier
  has_many  :languages,
            through: :language_classifications,
            uniq: true

  ##
  # Scopes
  scope :order_by_knight_score, order('categories.knight_score desc')

  ##
  # Validations
  validates :full_name, uniqueness: true
  validates :slug, uniqueness: true
  validates :short_description, length: {maximum: 360}

  ##
  # Setters
  def full_name=(new_full_name)
    if new_full_name != full_name
      # Set new full_name
      super

      # Set name
      md = new_full_name.match %r{(?<name>.*)[[:space:]]\(}
      self[:name] = md.present? ? md[:name].strip : new_full_name.strip

      # Set language_list
      set_languages(new_full_name)
    end
  end

  # REVIEW: Mark name readonly or even make virtual attribute (only set via full_name)
  def name=(new)
    raise 'DO NET SET NAME ON CATEGORY; SET FULL_NAME INSTEAD!'
  end

  # Languages
  def set_languages(new_full_name)
    md_langs = new_full_name.match %r{\((?<languages>.*)\)}
    if md_langs.present?
      langs = md_langs[:languages].downcase.split('/')

      LANGUAGES.each do |lang|
        langs.include?(lang) ? send("#{ lang }=", true) : send("#{ lang }=", false)
      end

      # if mobile then ios and android true, too
      self.mobile? ? (self.ios = true and self.android = true) : nil
    end
  end

  # Update languages of associated repos after commit
  after_commit :update_repo_languages
  def update_repo_languages
    repos(true).each { |repo| repo.save }
  end

  def language_list
    languages.map(&:name).join(', ')
  end

  def short_description
    self[:short_description].try(:html_safe) || " "
  end

  def popular_repos
    (repos[0..2] && repos[0..2].map(&:name).join(', ')) || ''
  end

  def further_repos
    (repos[3..100] && repos[0..3].map(&:name).join(', ')) || ''
  end

  ##
  # Set Stats in Callbacks
  before_save :set_stars
  before_save :set_knight_score

  def set_stars
    self.stars = repos.map(&:stars).reduce(:+) || 0
  end

  def set_knight_score
    self.knight_score = repos.map(&:knight_score).reduce(:+) || 0
  end

  # Description
  #   saved as markdown, rendered as html
  include MarkdownHelper  # use the same rendering settings everywhere
  def description
    d = self[:description] || " "
    @description ||= markdown.render(d).html_safe
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
    SwiftypeIndexWorker.perform_async('Category', id, :create)
  end

  def update_document
    SwiftypeIndexWorker.perform_async('Category', id, :update)
  end

  def destroy_document
    SwiftypeIndexWorker.perform_async('Category', id, :destroy)
  end

  ##
  # Mass Assignment Whitelist
  attr_accessible :full_name, :short_description, :description, :label
end
