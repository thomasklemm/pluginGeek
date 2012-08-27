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
  ###
  #   Modules
  ###
  # Friendly Id
  #   using history module (redirecting to new slug if slug changed)
  #   First language is considered to be main language
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Tagging
  acts_as_ordered_taggable_on :languages
  # acts_as_taggable_on :keywords # REVIEW: Implement as column if nescessary at all

  # Markdown
  include MarkdownHelper

  ###
  #   Scopes
  ###
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

  ###
  #   Life-Cycle Callbacks
  ###
  after_validation :move_friendly_id_error_to_name
  before_save :determine_languages
  after_save :touch_children

  # Move FriendlyId error to name so it is attached to
  # the input that is being displayed
  def move_friendly_id_error_to_name
    errors.messages[:name] = errors.messages.delete(:friendly_id)
  end

  # Determine Language and tag category appropriately
  def determine_languages
    match = /\((?<languages>.*)\)/.match(name)
    # match will be nill if there is no matching languages
    # as this is the only thing we are looking for
    languages = match[:languages] if match.present?
    self.language_list = languages.split('/').join(', ').downcase if languages
  end

  # Touch children to update repo count in cache
  def touch_children
    repos = Repo.tagged_with(self.name, on: :categories)
    repos.each { |repo| repo.touch }
  end

  ###
  #   Field Defaults
  ###
  def description
   self[:description] || ' '
  end

  def short_description
    self[:short_description] || ' '
  end

  ###
  #   Virtual Attributes
  ###
  # Render Markdown Description
  def description
    @description ||= self[:description].present? ? markdown.render(self[:description]).html_safe : ''
  end

  # Top Description and Bottom Description
  # seperated automagically by [REPOS]
  # FIX: TAG ENDINGS WHEN SPLITTING
  def top_description
    top_description = description.split('[REPOS]')[0] && description.split('[REPOS]')[0].html_safe
    @top_description ||= top_description || ''
  end

  def bottom_description
    bottom_description = description.split('[REPOS]')[1] && description.split('[REPOS]')[1].html_safe
    @bottom_description ||= bottom_description || ''
  end

  # Class methods
  # Bust Caches
  # by touching every category
  def self.bust_caches
    find_each { |category| category.touch }
  end

  # Clean up unused categories
  def self.clean
    categories = find_all_by_repo_count(0)
    categories.each { |c| c.destroy }
  end

  # Mass Assignment Whitelist
  attr_accessible :short_description, :description, :label

end
