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
#  languages         :integer
#  name              :string(255)
#  stars             :integer          default(0)
#  repos_count       :integer          default(0)
#

class Category < ActiveRecord::Base
  # Friendly Id
  #   using history module (redirecting to new slug if slug changed)
  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]

  # Repos
  has_many  :categorizations
  has_many  :repos,
            through: :categorizations,
            uniq: true

  # Languages
  include FlagShihTzu
  LANGUAGES = %w(ruby javascript design)
  LANGUAGES_WITH_SHORTCUTS = %w(ruby javascript design js)

  has_flags :column => 'languages',
            1 => :ruby,
            2 => :javascript,
            3 => :design

  # Alias js to javascript globally
  alias_method :js, :javascript
  alias_method :js=, :javascript=

  def self.js
    javascript
  end

  ##
  # Scopes
  # order_by_knight_score
  scope :order_by_knight_score, order('categories.knight_score desc')

  # language(:ruby) / language('ruby')
  scope :language, lambda { |lang| send(lang) if
    LANGUAGES_WITH_SHORTCUTS.include?(lang.to_s) }
  # find_all_by_language(:ruby)
  scope :find_all_by_language, lambda { |lang| language(lang).order_by_knight_score }

  ##
  # Validations
  validates :full_name, uniqueness: true
  validates :slug, uniqueness: true

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
      self[:full_name] = new_full_name

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
      # Replace js input with javascript
      langs.push('javascript') if langs.delete('js')
      LANGUAGES.each do |lang|
        langs.include?(lang) ? send("#{ lang }=", true) : send("#{ lang }=", false)
      end
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
  before_save :set_repos_count

  def set_stars
    self.stars = repos.map(&:stars).reduce(:+) || 0
  end

  def set_knight_score
    self.knight_score = repos.map(&:knight_score).reduce(:+) || 0
  end

  def set_repos_count
    self.repos_count = repos.size || 0
  end

  # Description
  #   saved as markdown, rendered as html
  include MarkdownHelper  # use the same rendering settings everywhere
  def description
    d = self[:description] || " "
    @description ||= markdown.render(d).html_safe
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
