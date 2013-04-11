# == Schema Information
#
# Table name: categories
#
#  created_at    :datetime         not null
#  description   :text
#  draft         :boolean          default(TRUE)
#  featured      :boolean          default(FALSE)
#  full_name     :text             not null
#  id            :integer          not null, primary key
#  language_list :text
#  repo_list     :text
#  repos_count   :integer          default(0)
#  score         :integer          default(0)
#  slug          :text             not null
#  stars         :integer          default(0)
#  updated_at    :datetime         not null
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

  # Named scopes
  def self.order_by_score
    order('categories.score DESC')
  end

  def self.order_by_name
    order('categories.full_name ASC')
  end

  def self.ids_and_full_names
    select([:id, :full_name]).
      order_by_score
  end

  def self.ids_and_full_names_without(repo)
    where('id != ?', repo.id).
      ids_and_full_names
  end

  # Retrieve a number of featured repos in random order
  def self.featured(count=1)
    ids = where(featured: true).pluck(:id)
    ids &&= ids.sample(count).shuffle
    where(id: ids)
  end

  # Autocomplete repo parents for select2
  def self.full_names_for_autocomplete
    order_by_score.
      pluck(:full_name).
      to_json
  end

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

  # Services
  has_many :service_categorizations,
    dependent: :destroy
  has_many :services,
    through: :service_categorizations

  # Defaults
  def stars
    self[:stars] || 0
  end

  def score
    self[:score] || 0
  end

  def name
    match = full_name.match %r{(?<name>.*)[[:space:]]\(}
    match.present? ? match[:name].strip : full_name
  end

  def similar_categories
    sc = (related_categories | reverse_related_categories).uniq
    sc.sort_by(&:stars).reverse
  end

  def self.expire_all
    update_all(updated_at: Time.current)
  end

  def extended_links
    @extended_links ||= extended_links!
  end

  # Assign aggregate stars of repos as category stars
  before_save :assign_stars

  # Assign aggregate scores of repos as category score
  before_save :assign_score

  # Assign languages from full_name
  before_save :assign_languages

  # Cache repo and language list
  before_save :cache_repos_count
  before_save :cache_repo_list
  before_save :cache_language_list

  after_commit :expire_repos
  after_commit :expire_languages

  private

  # Extended links include the links associated with repos of this category
  # in addition to the ones associated with the category itself,
  # all sorted by reverse published_at date
  def extended_links!
    l = (links | links_of_repos).uniq
    l.sort_by(&:published_at).reverse
  end

  def links_of_repos
    repos.includes(:links).flat_map(&:links)
  end

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

  def cache_repo_list
    self.repo_list = repos.map(&:name).join(', ')
  end

  def cache_repos_count
    self.repos_count = repos.length # uses the length of the already loaded array
  end

  # Cache only Web and Mobile if those main languages are present, don't display any sublanguages then
  def cache_language_list
    langs = languages.map(&:name)
    langs.include? 'Web'    and langs.delete_if {|lang| Language::Web.include?(lang.downcase)}
    langs.include? 'Mobile' and langs.delete_if {|lang| Language::Mobile.include?(lang.downcase)}
    self.language_list = langs.join(', ')
  end

  # Expire categories
  def expire_repos
    repos.update_all(updated_at: Time.current)
  end

  def expire_languages
    languages.update_all(updated_at: Time.current)
  end
end
