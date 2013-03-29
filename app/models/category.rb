# == Schema Information
#
# Table name: categories
#
#  created_at     :datetime         not null
#  description    :text
#  draft          :boolean          default(TRUE)
#  full_name      :text             not null
#  id             :integer          not null, primary key
#  language_names :text
#  repo_names     :text
#  score          :integer          default(0)
#  slug           :text             not null
#  stars          :integer          default(0)
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_score  (score)
#  index_categories_on_slug   (slug) UNIQUE
#

class Category < ActiveRecord::Base
  # Friendly Id using history module (redirecting to new slug if slug changed)
  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]

  # Validations
  validates :full_name, presence: true
  validates :description, length: {maximum: 360}

  # Order categories by score
  scope :order_by_score, order('categories.score DESC')

  # Autocomplete category full_names on repo#edit
  def self.full_names_for_autocomplete
    order_by_score.pluck(:full_name).to_json
  end

  def self.all_without(category)
    order_by_score.select { |c| c.id != category.id }
  end

  # Assign aggregate stars of repos as category stars
  before_save :assign_stars

  # Assign aggregate scores of repos as category score
  before_save :assign_score

  # Assign languages from full_name
  before_save :assign_languages

  # Cache repo names
  before_save :cache_repo_names

  # Cache language names
  before_save :cache_language_names

  # Update the languages of the associated repos
  after_commit :update_repo_languages

  # Repos
  has_many :categorizations,
    dependent: :destroy
  has_many :repos,
    through: :categorizations,
    order: 'repos.score DESC'

  # Languages
  has_many :language_classifications,
    as: :classifier,
    dependent: :destroy
  has_many :languages,
    through: :language_classifications

  # Links
  has_many :link_relationships,
    as: :linkable,
    dependent: :destroy
  has_many :links,
    through: :link_relationships,
    uniq: true

  # Related categories
  has_many :category_relationships,
    foreign_key: :other_category_id,
    dependent: :destroy

  has_many :reverse_category_relationships,
    class_name: 'CategoryRelationship',
    foreign_key: :category_id,
    dependent: :destroy

  has_many :related_categories,
    through: :category_relationships,
    source: :category

  has_many :reverse_related_categories,
    through: :reverse_category_relationships,
    source: :other_category

  def similar_categories
    sc = (related_categories | reverse_related_categories).uniq
    sc.sort_by(&:stars).reverse
  end

  private

  # Assign aggregate stars of repos as category stars
  def assign_stars
    self.stars = repos.map(&:stars).reduce(:+) || 0
  end

  # Assign aggregate scores of repos as category score
  def assign_score
    self.score = repos.map(&:score).reduce(:+) || 0
  end

  # Assign languages from full_name
  def assign_languages
    return unless full_name_changed?

    # Extract languages from full_name string
    match_data = full_name.match %r{\((?<languages>.*)\)}
    return unless match_data.present?

    langs = match_data[:languages].downcase.split('/').map(&:strip)
    return unless langs.present?

    # Reset languages
    self.languages = []

    # Set provided languages if they are known
    langs.each { |lang| assign_single_language(lang) }

    # Assign sublanguages if appropriate
    assign_web_languages if langs.include?('web')
    assign_mobile_languages if langs.include?('mobile')
  end

  def assign_web_languages
    Language::Web.each { |lang| assign_single_language(lang) }
  end

  def assign_mobile_languages
    Language::Mobile.each { |lang| assign_single_language(lang) }
  end

  def assign_single_language(lang)
    language = Language.find_by_slug(lang)
    self.languages << language if language
  end

  def cache_repo_names
    self.repo_names = repos.map(&:full_name).join(', ')
  end

  # Cache only Web and Mobile if those main languages are present, don't display any sublanguages then
  def cache_language_names
    langs = languages.map(&:name)
    langs.include? 'Web'    and langs.delete_if {|lang| Language::Web.include?(lang.downcase)}
    langs.include? 'Mobile' and langs.delete_if {|lang| Language::Mobile.include?(lang.downcase)}
    self.language_names = langs.join(', ')
  end

  # Update languages of each associated repo
  def update_repo_languages
    repos(true).each { |repo| repo.save }
  end
end
