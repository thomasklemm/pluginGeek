# == Schema Information
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

class Category < ActiveRecord::Base
  # Friendly Id
  #   using history module (redirecting to new slug if slug changed)
  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]

  ##
  # Audits
  # audited only: [:full_name, :short_description, :description]

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
  include FlagShihTzu
  LANGUAGES = %w(ruby javascript webdesign mobile ios android)
  has_flags :column => 'languages',
            1 => :ruby,
            2 => :javascript,
            3 => :webdesign,
            4 => :mobile,
            5 => :ios,
            6 => :android

  ##
  # Scopes
  # order_by_knight_score
  scope :order_by_knight_score, order('categories.knight_score desc')

  # language(:ruby) / language('ruby')
  scope :language, lambda { |lang| send(lang) if LANGUAGES.include?(lang.to_s) }
  # find_all_by_language(:ruby)
  scope :find_all_by_language, lambda { |lang| language(lang).order_by_knight_score }

  ##
  # Validations
  validates :full_name, uniqueness: true
  validates :slug, uniqueness: true
  validates :short_description, length: {maximum: 360}

  ##
  # Attributes and field defaults
  # def full_name
  #   self[:full_name]
  # end

  # def name
  #   self[:name]
  # end

  def full_name=(new_full_name)
    if new_full_name != full_name
      # Set names_and_languages
      super

      # Set name
      md_name = new_full_name.match %r{(?<name>.*)[[:space:]]\(}
      self[:name] = md_name.present? ? md_name[:name].strip : new_full_name.strip

      # Set language_list
      set_languages(new_full_name)
    end
  end

  def name=(new_name)
    # 1) Do nothing here
    # 2) Maybe raise a warning and an error if there is a try to set the name this way
    # 3) or allow and keep in sync with full_name
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

  def languages
    langs = LANGUAGES.each_with_object([]) { |lang, array| array << lang if send(lang) }
  end

  def language_list
    languages.join(', ')
  end

  def short_description
    (self[:short_description] && self[:short_description].html_safe) || " "
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
  # Bust Caches by touching every single category
  # Curious: There must a single SQL call for doing this on the whole table
  def self.touch_all
    find_each(&:touch)
  end

  ##
  # Mass Assignment Whitelist
  # TODO: strong params
  attr_accessible :full_name, :short_description, :description, :label
end
