# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  slug              :string(255)      not null
#  repo_count        :integer          default(0)
#  watcher_count     :integer          default(0)
#  knight_score      :integer          default(0)
#  short_description :text
#  description       :text
#  popular_repos     :string(255)
#  all_repos         :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  label             :string(255)
#

class Category < ActiveRecord::Base
  # Friendly Id
  #   using history module (redirecting to new slug if slug changed)
  #   First language is considered to be main language
  extend FriendlyId
  friendly_id :name_and_languages, use: [:slugged, :history]

  # Repos
  has_and_belongs_to_many :repos,
                          uniq: true

  # Tagging
  acts_as_ordered_taggable_on :languages

  # InstancesHelper
  include InstancesHelper
  ##
  # Scopes
  #
  # find_all_by_language_and_select_main_fields('ruby'),
  #  in use at categories#index
  # scope :ordered_find_all_by_language_and_select_main_fields, lambda { |language| find_all_by_language(language).select_main_fields.order_by_knight_score }

  # find_all_by_language('ruby'),
  #  find all categories tagged with given language
  #  if no language is given find all repos
  scope :find_all_by_language, lambda { |language| tagged_with(language.downcase, on: :languages) if language.present? }
  scope :ordered_find_all_by_language, lambda { |language| find_all_by_language(language).order_by_knight_score.visible }

  # select_main_fields,
  #  only select those fields that are relevant for _category partial
  #  if id can be selected it would work with caching
  # scope :select_main_fields, select([:name, :slug, :watcher_count, :label, :short_description, :repo_count, :popular_repos, :all_repos, :knight_score, :updated_at])

  # order_by_knight_score
  scope :order_by_knight_score, order('knight_score desc')

  # visible
  scope :visible, where('repo_count > 0')

  # most_recent_by_language('ruby')
  #   find the timestamp of the most recently updated category
  #   with fallback on a current 10.seconds window
  def self.timestamp_by_language(language)
    if timestamp = find_all_by_language(language).maximum(:updated_at)
      timestamp = timestamp.utc.to_s(:number)
    else
      DateTime.now.utc.to_s(:number).slice(0..(-2))
    end
  end

  ##
  # Life-Cycle Callbacks
  #
  # Move FriendlyId error to name_and_languages
  # so it is attached to the visible input field
  after_validation :move_friendly_id_error_to_name
  def move_friendly_id_error_to_name
    errors.messages[:name_and_languages] = errors.messages.delete(:friendly_id)
  end

  # Determine Language and tag category appropriately
  before_save :determine_languages
  def determine_languages
    match = /\((?<languages>.*)\)/.match(name) if name.instance_of? String
    # match will be nil if there is no matching languages
    # as this is the only thing we are looking for
    languages = match[:languages] if match.present?
    self.language_list = languages.split('/').join(', ').downcase if languages
  end

  ##
  # Field Defaults
  def description
   self[:description] || ' '
  end

  def short_description
    self[:short_description] || ' '
  end

  ##
  # Virtual Attributes
  #
  # def name_and_languages
  #   self[:name_and_languages]
  # end

  def name
    md = name_and_languages.match %r{(?<name>.*)[[:space:]]\(}
    @name ||= md.present? ? md[:name].strip : nil
  end

  def languages
    md = name_and_languages.match %r{\((?<languages>.*)\)}
    @languages ||= md.present? ? md[:languages].split('/') : nil
  end

  def language_list
    @language_list ||= languages.join(', ')
  end

  # Description (stored as markdown)
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
  def self.bust_caches
    find_each { |category| category.touch }
  end

  # Clean up unused categories
  def self.clean
    CategoryUpdater.update_categories_serial
    categories = find_all_by_repo_count(0)
    categories.each { |category| category.destroy }
  end

  ##
  # Mass Assignment Whitelist

  # label and name need only be accessible for admins
  attr_accessible :short_description, :description, :label, :name
end
