# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  slug               :string(255)      not null
#  repo_count         :integer          default(0)
#  watcher_count      :integer          default(0)
#  knight_score       :integer          default(0)
#  short_description  :text
#  description        :text
#  popular_repos      :string(255)
#  all_repos          :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  label              :string(255)
#  name_and_languages :string(255)
#  languages          :integer
#  name               :string(255)
#

class Category < ActiveRecord::Base
  # Friendly Id
  #   using history module (redirecting to new slug if slug changed)
  extend FriendlyId
  friendly_id :name_and_languages, use: [:slugged, :history]

  # Repos
  has_and_belongs_to_many :repos,
                          uniq: true

  # Languages
  include FlagShihTzu
  LANGUAGES = %w(ruby javascript design)
  has_flags :column => 'languages',
            1 => :ruby,
            2 => :javascript,
            3 => :design
  ##
  # Scopes
  # order_by_knight_score
  scope :order_by_knight_score, order('knight_score desc')

  # find_all_by_language(:ruby)
  scope :find_all_by_language, lambda { |lang| send(lang) if LANGUAGES.include?(lang.to_s) }
  scope :ordered_find_all_by_language, lambda { |lang| find_all_by_language(lang).order_by_knight_score }

  ##
  # Validations
  validates :name_and_languages, uniqueness: true
  validates :slug, uniqueness: true

  ##
  # Attributes and field defaults
  def name_and_languages
    self[:name_and_languages] || ''
  end

  def name_and_languages=(new_name_and_languages)
    if new_name_and_languages != name_and_languages
      # Set names_and_languages
      self[:name_and_languages] = new_name_and_languages

      # Set name
      md = new_name_and_languages.match %r{(?<name>.*)[[:space:]]\(}
      self[:name] = md.present? ? md[:name].strip : new_name_and_languages.strip

      # Set language_list
      # Start here for example
      # md = name.match %r{\((?<languages>.*)\)}
      # @languages ||= md.present? ? md[:languages].split('/') : nil
    end
  end

  def name
    md = name_and_languages.match %r{(?<name>.*)[[:space:]]\(}
    @name ||= md.present? ? md[:name].strip : nil
  end

  def name= (new_name)
    # 1) Do nothing here
    # 2) Maybe raise a warning and an error if there is a try to set the name this way
    # 3) or allow and keep in sync with name_and_languages
  end

  def languages

  end

  def language_list
    @language_list ||= languages.join(', ')
  end

  def short_description
    self[:short_description] || " "
  end

  # Description
  #   saved as markdown, rendered as html
  include MarkdownHelper
  def description
    @description ||= self[:description].present? ? markdown.render(self[:description]).html_safe : ''
  end

  # Top Description and Bottom Description seperated automagically by [REPOS]
  # FIX: DELETE REMAINING TAG ENDINGS WHEN SPLITTING
  def top_description
    top_description = description.split('[REPOS]')[0] && description.split('[REPOS]')[0].html_safe
    @top_description ||= top_description || ''
  end

  def bottom_description
    bottom_description = description.split('[REPOS]')[1] && description.split('[REPOS]')[1].html_safe
    @bottom_description ||= bottom_description || ''
  end

  ##
  # Class methods
  # Bust Caches by touching every single category
  # Curious: There must a single SQL call for doing this on the whole table
  def self.touch_all
    find_each { |category| category.touch }
  end

  ##
  # Mass Assignment Whitelist
  # TODO: label and name_and_languages need only be accessible for admins
  attr_accessible :short_description, :description, :label, :name_and_languages
end
